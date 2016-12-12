require 'inline'

class MyKmeans
	inline do |builder|
		builder.include 'opencv2/imgproc/imgproc.hpp'
		builder.include 'opencv2/highgui/highgui.hpp'
		builder.include 'mygraph'
		builder.include '<iostream>'
		builder.include '<algorithm>'
		builder.include 'opencv2/highgui/highgui.hpp'

    	builder.c '
    		struct User {
			  int chosenX;
			  int chosenY;
			  Mat clusteredImg; //for testing (doesnt get used for computations)
			  Mat skinImg; //img containing desired background/skin color
			  Mat destImg; //img to edit background & replace w/ skin color
			  Vec3b chosenColor;
			  bool colorPicked;
			};'

		builder.c '
			//finds the max number of vecs that are equal and returns it. 
			//if none are the same as eachother then returns null
			Vec3b findMaxCommon(Vec3b v1, Vec3b v2, Vec3b v3, Vec3b v4) {
			  bool v1v2 = areEqual(v1, v2);
			  bool v1v3 = areEqual(v1, v3);
			  bool v1v4 = areEqual(v1, v2);
			  bool v2v3 = areEqual(v1, v3);
			  bool v2v4 = areEqual(v1, v2);
			  bool v3v4 = areEqual(v1, v3);

			  if (v1v2 && v1v3 && v1v4) { //all equal
			    return v1;
			  } else if ((v1v2 && v1v3) || (v1v2 && v1v4) || (v1v3 && v1v4)) { //3 are equal (all including v1)
			    return v1;
			  } 

			  if (v2v3 && v2v4) {
			    return v2;
			  } 

			  //just pairs 
			  if (v1v2 || v1v3 || v1v4) {
			    return v1;
			  } else if (v2v3 || v2v4) {
			    return v2;
			  } else if (v3v4) {
			    return v3;
			  }
			  return v1; //no matching pairs: default is v1
			}'

		builder.c '
			void replaceBackground(Mat clusteredImg, Mat src, Vec3b backgroundColor, Vec3b newColor, String imgName) {
    
			  Mat new_image = clusteredImg;

			  //remove backgroundColor
			  int leftX = src.rows-1;
			  for( int y = 0; y < src.rows; y++ ) {
			    //starting from left side
			    for( int x = 0; x < src.cols; x++ ) { 
			      if (areEqual(new_image.at<Vec3b>(y,x), backgroundColor)) {
			        new_image.at<Vec3b>(y,x)[0] = newColor[0];
			        new_image.at<Vec3b>(y,x)[1] = newColor[1];
			        new_image.at<Vec3b>(y,x)[2] = newColor[2];
			      } else {
			        leftX = x;
			        break;
			      }
			    }
			    //not background
			    //check from other side of row now
			    //starting from right side 
			    int difference = 0;
			    for (int z = src.cols-1; z >= leftX; z-- ) {
			      if (areEqual(new_image.at<Vec3b>(y,z), backgroundColor)) {
			        new_image.at<Vec3b>(y,z)[0] = newColor[0];
			        new_image.at<Vec3b>(y,z)[1] = newColor[1];
			        new_image.at<Vec3b>(y,z)[2] = newColor[2];
			      } else {
			        //found other side of object 
			        difference = z - leftX;
			        break;
			      }
			    }
			    //fill in between the difference w/ src image 
			    // for (int i = leftX; i < leftX+difference; i++ ) {
			    //   new_image.at<Vec3b>(y,i) = src.at<Vec3b>(y,i);
			    // }
			  }

			  //resize image
			  cv::Size newSize;
			  int new_width = std::min(600, src.size().width);
			  newSize.width = new_width;
			  newSize.height = new_width * src.size().height / src.size().width;

			  resize(new_image, new_image, newSize);

			  User* u = new User();
			  u->destImg = new_image;

			  namedWindow(imgName, 1);
			  // setMouseCallback(imgName, CallBackFunction2, u);
			}'

		builder.c '
			void MyKmeans(User* u, String imgName) {
			  Vec3b newColor = u->chosenColor;

			  Mat src = u->destImg;
			  Mat samples(src.rows * src.cols, 3, CV_32F);
			  for( int y = 0; y < src.rows; y++ )
			    for( int x = 0; x < src.cols; x++ )
			      for( int z = 0; z < 3; z++)
			        samples.at<float>(y + x*src.rows, z) = src.at<Vec3b>(y,x)[z];

			  int clusters = 6;
			  Mat labels;
			  int attempts = 5;
			  Mat centers;
			  kmeans(samples, clusters, labels, TermCriteria(CV_TERMCRIT_ITER|CV_TERMCRIT_EPS, 10000, 0.0001), attempts, KMEANS_PP_CENTERS, centers );
			  
			  Mat new_image( src.size(), src.type());

			  for( int y = 0; y < src.rows; y++ ) {
			    for( int x = 0; x < src.cols; x++ )
			    { 
			      int cluster_idx = labels.at<int>(y + x*src.rows,0);
			      new_image.at<Vec3b>(y,x)[0] = centers.at<float>(cluster_idx, 0);
			      new_image.at<Vec3b>(y,x)[1] = centers.at<float>(cluster_idx, 1);
			      new_image.at<Vec3b>(y,x)[2] = centers.at<float>(cluster_idx, 2);
			    }
			  }
			  u->clusteredImg = new_image;
			  // namedWindow("clustered image", 3);
			  // setMouseCallback("clustered image", CallBackFunction3, u);
			  // imshow("clustered image", u->clusteredImg); 

			  //determine background color(s) and remove 
			  Vec3b colorTopLeft = new_image.at<Vec3b>(0,0);
			  Vec3b colorTopRight = new_image.at<Vec3b>(0, src.cols-1);
			  Vec3b colorBottomLeft = new_image.at<Vec3b>(src.rows-1, 0);
			  Vec3b colorBottomRight = new_image.at<Vec3b>(src.rows-1, src.cols-1);

			  Vec3b backgroundColor = findMaxCommon(colorTopLeft, colorTopRight, colorBottomLeft, colorBottomRight);

			  std::cout << "top:" << colorTopLeft << " " << colorTopRight << std::endl;
			  std::cout << "bottom:" << colorBottomLeft << " " << colorBottomRight << std::endl;
			  std::cout << "determined background-color: " << backgroundColor << std::endl;

			  //make BFS for clustered img
			  std::cout << "making graph now" << std::endl;
			  MyGraph* graph = new MyGraph(src, new_image, backgroundColor, u->chosenColor);
			  std::cout << "finished making graph " << std::endl;

			  //call BFS on background
			  Mat finalimg = graph->BFS_ReplaceBackground();
			  std::cout << \"finished doing all BFS\'s \" << std::endl;

			  //finally, resize image
			  cv::Size newSize; 
			  int new_width = std::min(600, src.size().width);
			  newSize.width = new_width;
			  newSize.height = new_width * src.size().height / src.size().width;
			  resize(finalimg, finalimg, newSize);

			  u->destImg = finalimg;
			  namedWindow(imgName, 1);
			  // setMouseCallback(imgName, CallBackFunction2, u);
			  // std::cout<<\"background color: \" << backgroundColor<<std::endl;

			  
			  cv::imwrite(\"../new_images/finalimg.jpg\", finalimg);

			  imshow(imgName, finalimg);

			  // old, linear replace background alg
			  //replaceBackground(new_image, src, backgroundColor, newColor, \"new image\");
			}'

		builder.c '
			int main( int argc, char** argv)
			{
			  User* u = new User();
			  u->colorPicked = false;

			  Mat skinImg = imread (argv[1], 1);
			  u->skinImg = skinImg; 
			  Mat destImg = imread( argv[2], 1 );
			  u->destImg = destImg;

			  u->chosenColor=(u->skinImg).at<Vec3b>(0,0); 
			  u->colorPicked = true;
			  MyKmeans(u, "new image");
			  waitKey( 0 );
			}'
	end
end



