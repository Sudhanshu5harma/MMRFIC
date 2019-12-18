## Copyright (C) 2012 Mike Miller <mtmiller@ieee.org>
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {@var{t} =} poly2trellis (@var{m}, @var{g})
##
## Convert convolutional code generator polynomials into trellis form.
##
## The arguments @var{m} and @var{g} together describe a rate k/n feedforward
## convolutional encoder.  The output @var{t} is a trellis structure describing
## the same encoder with the fields listed below.
##
## The vector @var{m} is a k-by-1 array containing the lengths of each of the
## shift registers for the k input bits to the encoder.
##
## The matrix @var{g} is a k-by-n octal-value matrix describing the generation
## of each of the n outputs from each of the k inputs.  For a particular entry
## of @var{g}, the least-significant bit corresponds to the most-delayed input
## bit in the kth shift-register.
##
## The returned trellis structure contains the following fields:
##
## @table @samp
## @item numInputSymbols
## The number of k-bit input symbols possible, i.e. 2^k.
##
## @item numOutputSymbols
## The number of n-bit output symbols possible, i.e. 2^n.
##
## @item numStates
## The number of states in the trellis.
##
## @item nextStates
## The state transition table for the trellis.  The ith row contains the indices
## of the states reachable from the (i-1)th state for each possible input
## symbol.
##
## @item outputs
## A table of octal-encoded output values for the trellis.  The ith row contains
## values representing the output symbols produced in the (i-1)th state for each
## possible input symbol.
## @end table
##
## Input symbols, output symbols, and encoder states are all interpreted with
## the lowest indices being the most significant bits.
##
## References:
##
##     [1] S. Lin and D. J. Costello, "Convolutional codes," in @cite{Error
##     Control Coding}, 2nd ed. Upper Saddle River, NJ: Pearson, 2004,
##     ch. 11, pp. 453-513.
##
## @seealso{istrellis}
## @end deftypefn

function t = poly2trellis (m, g)

  if (nargin != 2)
    print_usage ();
  endif

  ## Notation agrees with Lin & Costello for the most part:
  ## m = length of each modulo-2 adder
  ##   = 1 + nu(:) = one more than length of each shift register
  ## g = generator sequences, k-by-n
  ## k = bits per input symbol = number of shift registers
  ## n = bits per output symbol = number of modulo-2 adders
  [nr, k] = size (m);
  if (nr != 1)
    error ("poly2trellis: M must be a 1-by-k positive integer row vector");
  endif
  if (! (all (m == fix (m)) && all (m > 0)))
    error ("poly2trellis: M must be a 1-by-k positive integer row vector");
  endif

  [nr, n] = size (g);
  if (nr != k)
    error ("poly2trellis: G must be a k-by-n octal matrix");
  endif

  ## Convert g to decimal, let oct2dec validate the octal values
  g = oct2dec (g);

  ## Check the ranges of the generators
  ## nu = total number of linear shift registers for all k
  nu = sum (m) - k;

  ## Number of states and input symbols needed to capture the state machine
  nstates  = 2^nu;
  ninputs  = 2^k;
  noutputs = 2^n;

  t = struct ("numInputSymbols",  ninputs,
              "numOutputSymbols", noutputs,
              "numStates",        nstates,
              "nextStates",       zeros (nstates, ninputs),
              "outputs",          zeros (nstates, ninputs));

  ## Split state indices into values for each distinct shift register.
  ## Also precalculate new bit position for each shift register and the left
  ## shifts required to reassemble the states into one state value.
  ##
  ## Conventions:
  ## - Each shift register shifts to the right, MSB-to-LSB
  ## - The MSB of each shift register is the newest input
  ## - The MSBs of the state represent the k=1 shift register
  statebits = de2bi (0:nstates - 1);
  states = zeros (nstates, k);
  newbit = zeros (1, k);
  shifts = zeros (1, k);
  offset = 1;
  for i = 1:k
    nu_i = m(i) - 1;
    if (nu_i > 0)
      states(:,i) = bi2de (statebits(:, offset:offset + nu_i - 1));
    endif
    newbit(i) = bitshift (1, nu_i);
    shifts(i) = offset - 1;
    offset += nu_i;

    if (any (g(i,:) >= 2^m(i)))
      error ("poly2trellis: code size is greater than constraint length");
    endif
    if (all (g(i,:) < 2^nu_i) || !any (mod (g(i,:), 2)))
      error ("poly2trellis: code size is less than constraint length");
    endif
  endfor

  ## Generate conversion list of all possible output octal values
  outputs = str2num (dec2base (0:noutputs - 1, 8));

  ## Walk the trellis, each row index is state, each column index is input
  for s = 1:nstates

    for i = 1:k
      ## For each next input bit [0,1] calculate inputs to modulo-2 adder
      ## and the next state for the ith linear shift register, left-shifted
      ## to be combined into the total state.
      state = states(s,i) + [0; newbit(i)];
      next = bitshift (bitshift (state, -1), shifts(i));

      ## Calculate the modulo-2 sum of the state plus input for each n for
      ## this particular shift register.
      ## The MSB of the output represents the n=1 generator(s)
      out = [0; 0];
      for adder = 1:n
        val = mod (sum (de2bi (bitand (g(i, adder), state)), 2), 2);
        out += bitshift (val, n - adder);
      endfor

      ## Accumulate contributions to the trellis for this shift register.
      ## The contribution to each input symbol depends on whether the
      ## (k-i)th bit is 0 or 1.
      bitpos = k - i;
      for symbol = 1:ninputs
        idx = bitget (symbol - 1, bitpos + 1) + 1;
        t.nextStates(s, symbol) += next(idx);
        t.outputs(s, symbol) = bitxor (t.outputs(s, symbol), out(idx));
      endfor

    endfor

    ## Convert output values to octal representation
    t.outputs(s,:) = outputs(t.outputs(s,:) + 1);

  endfor

endfunction

%% Test the simple (2,1,3) encoder from Lin & Costello example 11.1
%!test
%! T = struct ("numInputSymbols",  2,
%!             "numOutputSymbols", 4,
%!             "numStates",        8,
%!             "nextStates",       [0 4; 0 4; 1 5; 1 5; 2 6; 2 6; 3 7; 3 7],
%!             "outputs",          [0 3; 3 0; 3 0; 0 3; 1 2; 2 1; 2 1; 1 2]);
%! t = poly2trellis (4, [13 17]);
%! assert (t, T)
%! assert (istrellis (t), true)

%% Test input validation
%!error poly2trellis ()
%!error poly2trellis (1, 2, 3)
%!error poly2trellis (1)
%!error poly2trellis (2, 8)
%!error poly2trellis (0, 0)
%!error poly2trellis (2, 0)
%!error poly2trellis (2, 2)
%!error poly2trellis (2, 7)
