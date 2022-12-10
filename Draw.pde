void DrawPoint(float x,float y,float radius,Colour colour){
    stroke(colour.R,colour.G,colour.B);
    fill(colour.R,colour.G,colour.B);
    circle(x,y,radius);
}

void DrawLine(float x1, float y1,float x2,float y2,Colour colour,float thickness){
  stroke(colour.R,colour.G,colour.B);
  strokeWeight(thickness);
  line(x1,y1,x2,y2);
}


void DrawPointMatrix(Matrix points,Colour pointcolour,Colour linecolour,float linethickness,boolean drawline,boolean drawpoints,float PointRadius,boolean cyclical){
  if(points.ColNum>2 && drawline && cyclical){
    DrawLine(points.matrix.get(0).get(0),points.matrix.get(0).get(1),points.matrix.get(points.matrix.size()-1).get(0),points.matrix.get(points.matrix.size()-1).get(1),
             linecolour,linethickness);
  }
  
  for(int j =0 ;j<points.ColNum;j++){
    
    if(j!=points.ColNum-1 && drawline){
      DrawLine(points.matrix.get(j).get(0),points.matrix.get(j).get(1),points.matrix.get(j+1).get(0),points.matrix.get(j+1).get(1),linecolour,linethickness);
    }
    if(drawpoints){
      DrawPoint(points.matrix.get(j).get(0),points.matrix.get(j).get(1),PointRadius,pointcolour);

    }
    
    
  }
  

}

void DrawGrid(int rownum,int colnum,Colour GridLineColour, float GridLinesThickness,int graphwidth,int graphheight){
  
  
  
  
  float xspacing = float(graphwidth/colnum);
  float yspacing = float(graphheight/rownum);
  
  for(int r =0; r<rownum;r++){
    DrawLine(0,r*yspacing,graphwidth,r*yspacing,GridLineColour,GridLinesThickness);
  }
  for(int c =0; c<colnum;c++){
    DrawLine(c*xspacing,0,c*xspacing,graphheight,GridLineColour,GridLinesThickness);
  }
  DrawLine(graphwidth/2,0,graphwidth/2,graphheight,GridLineColour,GridLinesThickness*2);
  DrawLine(0,graphheight/2,graphwidth,graphheight/2,GridLineColour,GridLinesThickness*2);
  
  
} 

Point MapPointToCanvas(Point point,int colnum,int rownum,int graphwidth,int graphheight){
  float x = point.x+float(colnum/2);
  x*=float(graphheight/colnum);
  float y = point.y*-1;
  y+=float(rownum/2);
  y*=float(graphheight/rownum);
  return new Point(x,y);
}
Point MapPointToCartesian(Point point,int colnum,int rownum,int graphwidth,int graphheight){
  float x = point.x/float(graphwidth/colnum);
  x-=float(colnum/2);
  
  float y = point.y/ float(graphheight/rownum);
  y*=-1;
  y+=float(rownum/2);
  return new Point(x,y);
}




Matrix MapToCanvas(Matrix points,int rownum,int colnum,int graphwidth,int graphheight){
  Matrix transformedmatrix= new Matrix();
  
   
  
  transformedmatrix=points.ScaleRow(1,-1f);

  transformedmatrix=transformedmatrix.AddValueToRow(0,float(colnum/2));
  transformedmatrix=transformedmatrix.AddValueToRow(1,float(rownum/2));
 
  
  float horizontalscale = (float(graphwidth)/float(colnum));
  float verticalscale = (float(graphheight)/float(rownum));
  
  transformedmatrix=transformedmatrix.ScaleRow(0,horizontalscale);
  transformedmatrix=transformedmatrix.ScaleRow(1,verticalscale);
  
  return transformedmatrix;
}

Matrix MapToCartesian(Matrix points,int colnum,int rownum,int graphwidth,int graphheight){
  Matrix transformedmatrix= new Matrix();
  
  float horizontalscale = 1/(float(graphwidth)/float(colnum));
  float verticalscale = 1/(float(graphheight)/float(rownum));

  transformedmatrix=points.ScaleRow(0,horizontalscale);
  transformedmatrix=transformedmatrix.ScaleRow(1,verticalscale);
  
     // flip row
  transformedmatrix=transformedmatrix.ScaleRow(1,-1f);
  
  transformedmatrix=transformedmatrix.AddValueToRow(0,-float(colnum/2));
  transformedmatrix=transformedmatrix.AddValueToRow(1,float(rownum/2));
 

  
  return transformedmatrix;
}

void DrawListOfMatrices(ArrayList<Matrix> matrixlist,boolean lines ,Colour linecolour, boolean points, Colour pointcolour, float linethickness,float pointradius ){

}

//void DrawTransformedGridMatrices(){
  //for (int i =0 ; i<TransformedGridMatrices.size();i++){
   // DrawPointMatrix(TransformedGridMatrices.get(i),PointColour,PointsLineColour,0,true,false);
  //}
//}

//void DrawText(){
  //stroke(0);
  //textFont(createFont("Arial", 20, true), 20);
  //fill(0);
  //text("Click to draw points", graphwidth+20, 100);
  //text("Press P to transform the points", graphwidth+20, 200);
  //text("Press R to reset the points", graphwidth+20, 300);
  //text("Press G to toggle the transformed grid", graphwidth+20, 400);
  //text("Input your own matrix below", graphwidth+20, 500);

//}
