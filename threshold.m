function [mean,mask] = threshold(img)
mean = sum(img(:))/((length(img))^2);
mask = img>mean;
mask = imerode(mask,strel('disk',8));
mask = imdilate(mask,strel('disk',8));
end