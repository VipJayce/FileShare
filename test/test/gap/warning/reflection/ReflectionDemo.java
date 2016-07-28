/**
 * Copyright 2003-2010 UFIDA Software Engineering Co., Ltd. 
 */
package test.gap.warning.reflection;

/**
 * @author maxiao
 *
 */
public class ReflectionDemo implements IReflectionDemo {

    /* (non-Javadoc)
     * @see test.gap.warning.reflection.IReflectionDemo#getString()
     */
    public String getString() {
        // TODO Auto-generated method stub
        return "maxiao";
    }

    /* (non-Javadoc)
     * @see test.gap.warning.reflection.IReflectionDemo#getString(java.lang.String, int)
     */
    public String getString(String name, int age) {
        // TODO Auto-generated method stub
        return "hello  "+name+"====age===="+age;
    }

    /* (non-Javadoc)
     * @see test.gap.warning.reflection.IReflectionDemo#getString(java.lang.String)
     */
    public int getString(String name) {
        // TODO Auto-generated method stub
        return 0;
    }

    /* (non-Javadoc)
     * @see test.gap.warning.reflection.IReflectionDemo#printlnName(java.lang.String)
     */
    public void printlnName(String name) {
        // TODO Auto-generated method stub
        System.out.println("printlnName===="+name);
    }
    
    
    public static String getStaticName(String name){
        return "static "+name;
    }
}
