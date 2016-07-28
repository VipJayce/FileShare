/**
 * Copyright 2003-2010 UFIDA Software Engineering Co., Ltd. 
 */
package test.gap.warning.reflection;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import junit.framework.TestCase;

/**
 * @author maxiao
 *
 */
public class TestReflection extends TestCase {
    private BeanFactory bf=null;
    /* (non-Javadoc)
     * @see junit.framework.TestCase#setUp()
     */
    protected void setUp() throws Exception {
        bf = new FileSystemXmlApplicationContext(
                new String[] { "classpath:test/gap/warning/reflection/spring.xml" });
    }

    /* (non-Javadoc)
     * @see junit.framework.TestCase#tearDown()
     */
    protected void tearDown() throws Exception {
        super.tearDown();
    }
    /**
     * 测试静态方法
     */
    /*public void TestStaticClass(){
        Object object = null;
        Method method=null;
        Object result=null;
        object = bf.getBean("reflectionDemo_target");
        try {
            method=object.getClass().getMethod("getString");
            result=method.invoke(object);
            System.out.println("result===="+result);
        } catch (SecurityException e) {
            e.printStackTrace();
            fail();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
            fail();
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            fail();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
            fail();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
            fail();
        }
             
         assertEquals("maxiao", result);
        
    }*/
    /**
     * 测试方法调用
     */
    public void testUnParameter(){
        Object object = null;
        Method method=null;
        Object result=null;
        object = bf.getBean("reflectionDemo_target");
        try {
            //无参数调用
            method=object.getClass().getMethod("getString");
            result=method.invoke(object);
            System.out.println("无参数调用===="+result);
            assertEquals("maxiao", result);
            
            //有单个参数调用
            method=object.getClass().getMethod("getString",String.class);
            result=method.invoke(object,"maxiao");
            System.out.println("有单个参数调用===="+result);
            assertEquals(0, result);
            
            //有多个参数调用
            method=object.getClass().getMethod("getString",String.class,int.class);
            result=method.invoke(object,"maxiao",18);
            System.out.println("有多个参数调用===="+result);
            assertEquals("hello  maxiao====age====18", result);
            
            //无返回值调用
            method=object.getClass().getMethod("printlnName",String.class);
            result=method.invoke(object,"maxiao");
            System.out.println("无返回值调用===="+result);
            
            
            //静态方法调用
            method=Class.forName("test.gap.warning.reflection.ReflectionDemo").getMethod("getStaticName",String.class);
            result=method.invoke(object,"静态方法调用");
            System.out.println("静态方法调用===="+result);
            
            
            //无返回值调用
            method=Class.forName("test.gap.warning.reflection.ReflectionDemo").getMethod("printlnName",String.class);
            result=method.invoke(object,"maxiao");
            System.out.println("无返回值调用===="+result);
            
        } catch (SecurityException e) {
            e.printStackTrace();
            fail();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
            fail();
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            fail();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
            fail();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
            fail();
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            fail();
        }

    }


}
