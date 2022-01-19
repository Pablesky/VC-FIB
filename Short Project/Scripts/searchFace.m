function [outImg, bbox] = searchFace(imagen)
    Detector = vision.CascadeObjectDetector('FrontalFaceLBP');
    bbox = step(Detector, imagen);
    outImg = imagen(bbox(2):(bbox(2) + bbox(4)), bbox(1):(bbox(1) + bbox(3)) , :);
end