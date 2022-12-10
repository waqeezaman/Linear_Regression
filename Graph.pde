class Graph{
  public int Height;
  public int Width;
  private int  ColNum;
  private int RowNum;
  
  private Colour GridLineColour= new Colour(0,0,0);
  private float GridLineThickness= 1;
  
  private Matrix XAxis = new Matrix();
  private Matrix YAxis = new Matrix();
  
  private Colour AxisColour= new Colour(0,0,0);
  private float AxisThickness= 2;
  
  
  
  ArrayList<Matrix> GridMatrices=new ArrayList<Matrix>();
  
  
  public Graph(int h,int w ,int c,int r){
    Height=h;
    Width=w;
    ColNum=c;
    RowNum=r;  
    
    CreateGridMatrices();
    
    XAxis.AddColumn(new Float[]{-5f,0f});
    XAxis.AddColumn(new Float[]{5f,0f});
    
    YAxis.AddColumn(new Float[]{0f,-5f});
    YAxis.AddColumn(new Float[]{0f,5f});



  }

  
  
  void CreateGridMatrices() {
  
  GridMatrices= new ArrayList<Matrix>();
  for (float r =-100; r<RowNum+100; r++) {
    Matrix m=new Matrix(2, 2, new float[]{-100, 100, r, r});
   
    GridMatrices.add(m);
  }

  for (float c =-100; c<ColNum+100; c++) {
    Matrix m = new Matrix(2, 2, new float[]{c, c, -100, 100});


    GridMatrices.add(m);
  }
}

public void Draw(){
  for (Matrix m : GridMatrices){
    DrawPointMatrix(MapToCanvas(m,RowNum,ColNum,Width,Height),GridLineColour,GridLineColour,GridLineThickness,true,false,0,false);
  }
  
  DrawPointMatrix(MapToCanvas(XAxis,RowNum,ColNum,Width,Height),AxisColour,AxisColour,AxisThickness,true,false,0,false);  
  DrawPointMatrix(MapToCanvas(YAxis,RowNum,ColNum,Width,Height),AxisColour,AxisColour,AxisThickness,true,false,0,false);  

}


}
