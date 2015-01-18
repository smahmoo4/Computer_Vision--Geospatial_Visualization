import java.io.*;
import java.util.*; 
import java.math.BigDecimal; 

class ColorPointExtraction {
	public static void main(String[] args) {
		
		try {
			
		   Scanner pathScan = new Scanner(new FileReader("/Users/Saaduddin/Desktop/paths.txt/"));
			String line = "";
			File file = new File("outLane.txt"); //create a file called out.txt
			File file2 = new File("outBoundary.txt");
			if(!file.exists())
				file.createNewFile(); 
			if(!file2.exists())
				file2.createNewFile(); 
			FileWriter fw = new FileWriter(file.getAbsoluteFile());
			FileWriter fw2 = new FileWriter(file2.getAbsoluteFile());

			BufferedWriter bw = new BufferedWriter(fw);
			BufferedWriter bw2 = new BufferedWriter(fw2);

			int count = 0; 
			int tempcounter = 0;
			
			//FINAL THRESHOLD
			
			double elev1 = 144.89477777777777; //our lower and upper bounds for the lane and boundary points
			double elev2 = 144.89655555555555;
			while(pathScan.hasNextLine())
				{
				String path = pathScan.nextLine();
				tempcounter++;
				if(tempcounter > 1713) // 1713 = number of dumpfiles; change this if you want to select a different upper limit
					{
					System.out.println("Number of paths: " + tempcounter);
					break;
					}
					
					if(tempcounter>0)   //change this number if you want to run it on a different set of files
						{
						Scanner scan = new Scanner(new FileReader(path));
						while(scan.hasNextLine())
							{
							line = scan.nextLine(); 
							String tokens [] = line.split(","); //split the line into an array of strings
							double elevation  = Double.parseDouble(tokens[4].trim()); 
	 						BigDecimal bd = new BigDecimal(String.valueOf(elevation)).setScale(14, BigDecimal.ROUND_HALF_UP); //keeps elevation value set to 14 decimal places
							elevation = Double.parseDouble(bd.toString()); 
							int intensity = Integer.parseInt(tokens[5].trim()); //need intensity for parameter							
							//isolate the lane markings 
							if(elevation < elev2 && intensity > 225)
								{
								count++;
								bw.write(tokens[2].trim()+" "+tokens[3].trim()+" "+tokens[4].trim()+"\n");
								}
								//isolate the boundary markins
							else if(elevation > elev1 && elevation < elev2) 
							//if elevation falls between threshold range 
								{
								count++;
								bw2.write(tokens[2].trim()+" "+tokens[3].trim()+" "+tokens[4].trim()+"\n");
								} //write the X Y Z components to a text file
							
							}	
						scan.close();
						}
			}
			
			pathScan.close(); 
			bw.close();
			bw2.close();
			System.out.println(count);
			System.out.println("DONE");
		
		} //try block
		
		catch (IOException ioe) {
		System.out.println("FNF");
		}
		
}
}