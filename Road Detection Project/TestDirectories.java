import java.io.*;

class TestDirectories{
	public static void main(String[] args) {
		
		try{
		String [] dirs = listFolders("class_project"); //WRITE PATH HERE
		
		File file = new File("paths.txt");
			if(!file.exists())
					file.createNewFile(); 
		FileWriter fw = new FileWriter(file.getAbsoluteFile());
		BufferedWriter bw = new BufferedWriter(fw);
		int count = 0; 
		
		for (int i = 1; i < dirs.length; i++) {
			String [] dumpFiles = txtFiles(currentDir()+dirs[i]);
				for (int j = 0; j < dumpFiles.length; j++) {
					
					if(dumpFiles[j].contains("index")) {
							continue; 
						}
					count++;
					bw.write(dumpFiles[j] +"\n");
				}			
		}
		bw.close(); 
		System.out.println(count);
		System.out.println("DONE");
	
		}
	
	catch(IOException ioe)
	{
		System.out.println("FNF");
	}
	
	}
	
	 public static String[] listFolders(String directoryName){
	 	
		File directory = new File(directoryName);
	 	//get all the files from a directory
	   File[] fList = directory.listFiles();
		String [] fListStr = new String[fList.length]; 
	 
		for (int i = 1; i< fList.length; i++){
	      if (fList[i].isDirectory())
	         fListStr[i] ="/"+fList[i].toString()+"/";
	  	}
				return fListStr; 
	 }
	
	 public static String[] txtFiles(String aDirPath){
		    
			 File dir = new File(aDirPath);
		    File[] textFiles = dir.listFiles(new FilenameFilter(){ 
		    	            public boolean accept(File dir, String filename)
		    	              { return filename.endsWith(".txt"); }
		    				} );
		    String[] pathArr = new String[textFiles.length];
		    for(int i = 0; i < textFiles.length; i++)
		    	{
		    	pathArr[i] = textFiles[i] + "";
		    	}
				return pathArr;
		    }
		
	public static String currentDir()
			{
				final String dir = System.getProperty("user.dir");
	      		  return dir;
			}
	
}