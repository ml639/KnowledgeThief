/*var  variationX, variationY;
    variationX = 0.001;
    variationY = 0.0015;

function c() {

    var canvas, context, image, imageData, x, y, offset;
     
    canvas = $("#canvas")[0];
    context = canvas.getContext("2d");

    imageData = context.createImageData(canvas.width, canvas.height);
    var randomColor1 = Math.floor(Math.random() * 256);
    var randomColor2 = Math.floor(Math.random() * 256);
    var randomColor3 = Math.floor(Math.random() * 256);
    variationX= Math.random() * 0.01 + .02;
    variationY = Math.random() * 0.01  + .01;
    for(y = 0; y < imageData.height; y += 1) {
        for(x = 0; x < imageData.width; x += 1) {
            offset = x * 4 + y * 4 * imageData.width;
            imageData.data[offset] = Math.sin(x * variationX) * 125 + 120;
            imageData.data[offset + 1] =  126;
            imageData.data[offset + 2] = Math.sin(x * variationX + y * variationY) * 127 + 128;
            imageData.data[offset + 3] = 255;
        }
    }
    variationX += variationX;
    variationY += variationY;

    context.putImageData(imageData, 0, 0);
}*/