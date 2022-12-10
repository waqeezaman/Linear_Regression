char ResetKey='r';

Graph BaseGraph = new Graph(1000,1000,10,10);

Matrix Points = new Matrix();

Matrix BestFitLine=new Matrix(2,2,new float[]{-10,10,0,0});
float Gradient;
float YIntercept;
float XMean;
float YMean;

void settings(){
  size(BaseGraph.Width,BaseGraph.Height);
}

void setup(){
}

void draw(){
  background(255);
  BaseGraph.Draw();
  DrawPointMatrix(MapToCanvas(Points,BaseGraph.RowNum,BaseGraph.ColNum,BaseGraph.Width,BaseGraph.Height),new Colour(255,0,0),new Colour(),0,false,true,10,false);
  DrawPointMatrix(MapToCanvas(BestFitLine,BaseGraph.RowNum,BaseGraph.ColNum,BaseGraph.Width,BaseGraph.Height),new Colour(255,0,0), new Colour(),2,true,false,0,false);  
 


}



void mousePressed(){
  AddPoint(mouseX,mouseY);
}


void AddPoint(float x,float y){
  if(x<BaseGraph.Width && y<BaseGraph.Height){
      Point newpoint= MapPointToCartesian(new Point(x,y),BaseGraph.RowNum,BaseGraph.ColNum,BaseGraph.Width,BaseGraph.Height);
      Points.AddColumn(new Float[]{newpoint.x,newpoint.y});
      ChangeLine();
      println("grad:" + Gradient);
      println("c:" + YIntercept);
  }
  

}
void ChangeLine(){
  XMean=GetMean(Points.GetRow(0));
  YMean=GetMean(Points.GetRow(1));
  Gradient=GetGradient(Points,XMean,YMean);
  YIntercept=GetYIntercept(XMean,YMean,Gradient);
  BestFitLine.Set(1,0,(BestFitLine.Get(0,0)*Gradient)+YIntercept);
  BestFitLine.Set(1,1,(BestFitLine.Get(0,1)*Gradient)+YIntercept);

}


float GetGradient(Matrix points,float xmean,float ymean){
   
   float numeratorsum=0;
   float denominatorsum=0;
   
   for(ArrayList<Float> p:points.matrix){
     numeratorsum+=(p.get(0)-xmean)*(p.get(1)-ymean);
     denominatorsum+=(p.get(0)-xmean)*(p.get(0)-xmean);
   }
   return numeratorsum/denominatorsum;
}

float GetYIntercept(float xmean,float ymean,float gradient){
  return ymean-xmean*gradient;
  
}




float GetMean(float[] values){
  float sum=0;
  for(float f: values){
    sum+=f;
  }
  
  return sum/values.length;
}




void keyPressed(){

  if(key==ResetKey){
      Points=new Matrix();
   }
}
