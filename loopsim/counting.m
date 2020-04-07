close all;
clc;
clear all;
vid=imaq.VideoDevice('winvideo',1,'RGB24_640x480');
%set(vid,'ReturnedColorSpace','grayscale');
%preview(vid);
while 1
dntshw=false;
pause(.001);
%acquireimage from webcam
%capture frame
frame = step(vid);
%Read the image, and capture the dimensions
img=uint8(255*frame);
out=skinDetect2Func(img);
stats=regionprops(out,'Centroid');
if length(stats)
    cx=stats.Centroid(1);
    cy=stats.Centroid(2);
    %find the nearest countour point
    boundary=bwboundaries(out);
    minDist=2*640*640;
    mx=cx;
    my=cy;
    bImg=uint8(zeros(480,640));
    for i=1:length(boundary)
        cell=boundary{i,1};
        for j=1:length(cell)
            y=cell(j,1);
            x=cell(j,2);
            sqrDist=(cx-x)*(cx-x)+(cy-y)*(cy-y);
            bImg(x,y)=255;
            if(sqrDist<minDist)
                minDist=sqrDist;
                mx=x;
                my=y;
            end
        end   
    end
   
    sed=strel('disk',round(sqrt(minDist)/2));
    final=imerode(out,sed);
    final=imdilate(final,sed);
    final=out-final;
   
    final=bwareaopen(final,200);
    final=imerode(final,strel('disk',10));
    final=bwareaopen(final,400);
   
    [L,num]=bwlabel(final,8);
    final=imclearborder(final,8);

    imshow(final);
   
else
    imshow(out)
end
% imshow(bImg);
end
