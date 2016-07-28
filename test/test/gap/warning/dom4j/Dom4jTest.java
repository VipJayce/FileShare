/**
 * Copyright 2003-2010 UFIDA Software Engineering Co., Ltd. 
 */
package test.gap.warning.dom4j;

import java.io.ByteArrayInputStream;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import junit.framework.TestCase;

/**
 * @author maxiao
 *
 */
public class Dom4jTest extends TestCase {

    /* (non-Javadoc)
     * @see junit.framework.TestCase#setUp()
     */
    protected void setUp() throws Exception {
        super.setUp();
    }

    /* (non-Javadoc)
     * @see junit.framework.TestCase#tearDown()
     */
    protected void tearDown() throws Exception {
        super.tearDown();
    }
    
    
    public void testRead() {
        
        String xmlString="<?xml version='1.0' encoding='UTF-8'?>" +
        "<messages><!--返回失败的消息集合-->" +
        "<message><!--具体的一条失败消息-->" +
        "<who>马啸</who><!--收件人名称-->" +
        "<whoid>maxiaoid</whoid><!--收件人主键-->" +
        "<sendtype>webmessage</sendtype><!--发送类型-->" +
        "<errormessage>失败</errormessage><!--失败信息-->" +
        "</message>" +
        "<message><!--具体的一条失败消息-->" +
        "<who>马啸</who><!--收件人名称-->" +
        "<whoid>maxiaoid</whoid><!--收件人主键-->" +
        "<sendtype>msn</sendtype><!--发送类型-->" +
        "<errormessage>失败</errormessage><!--失败信息-->" +
        "</message>" +
        "</messages>";

        
        
        
        SAXReader reader = new SAXReader();
        
        Document document=null;
        try {
            document = reader.read(new ByteArrayInputStream(xmlString.getBytes("UTF-8")));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            fail();
        } catch (DocumentException e) {
            e.printStackTrace();
            fail();
        }
        
        List<Element> list = document.selectNodes( "//message" );
        
        Iterator<Element> it=list.iterator();
        
        while(it.hasNext()){
            Element element= it.next();
            
            System.out.println("who----"+element.elementText("who"));
            
            System.out.println("whoid----"+element.elementText("whoid"));
            
            System.out.println("sendtype----"+element.elementText("sendtype"));
            
            System.out.println("errormessage----"+element.elementText("errormessage"));
        }
        
        assertNotNull(list);
        
    }

}
