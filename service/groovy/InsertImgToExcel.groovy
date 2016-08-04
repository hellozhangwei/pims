import org.apache.poi.ss.usermodel.ClientAnchor
import org.apache.poi.ss.usermodel.CreationHelper
import org.apache.poi.ss.usermodel.Drawing
import org.apache.poi.ss.usermodel.Picture
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.xssf.usermodel.XSSFSheet
import org.apache.poi.xssf.usermodel.XSSFWorkbook

String file = "d:/hello/gg.xlsx";
Workbook wb = new XSSFWorkbook(file);
XSSFSheet sheet = wb.getSheet("Sheet1");

InputStream is = new FileInputStream("d:/hello/image2.jpg");
CreationHelper helper = wb.getCreationHelper();
int pictureIdx = wb.addPicture(is,Workbook.PICTURE_TYPE_JPEG);
is.close();
ClientAnchor anchor = helper.createClientAnchor();
Drawing drawing = sheet.createDrawingPatriarch();
anchor.setDx1(0);
anchor.setDy1(0);
anchor.setDx2(1500);
anchor.setDy2(1500);
anchor.setCol1(0);
anchor.setRow1(0);
anchor.setRow2(4);
anchor.setCol2(2);
Picture pict = drawing.createPicture(anchor, pictureIdx);

FileOutputStream fileOut = new FileOutputStream(file,true);
    try{
        wb.write(fileOut);
    }catch (IOException e){
            e.printStackTrace();
    }finally{
            fileOut.close();
            wb.close();
    }