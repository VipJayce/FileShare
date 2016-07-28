function forbidBackSpace(e) {  
	var ev = e || window.event; //��ȡevent����   
	var obj = ev.target || ev.srcElement; //��ȡ�¼�Դ   
	var t = obj.type || obj.getAttribute('type'); //��ȡ�¼�Դ����   
	//��ȡ��Ϊ�ж��������¼�����   
	var vReadOnly = obj.readOnly;  
	var vDisabled = obj.disabled;  
	//����undefinedֵ���   
	vReadOnly = (vReadOnly == undefined) ? false : vReadOnly;  
	vDisabled = (vDisabled == undefined) ? true : vDisabled;  
	//����Backspace��ʱ���¼�Դ����Ϊ������С������ı��ģ�   
	//����readOnly����Ϊtrue��disabled����Ϊtrue�ģ����˸��ʧЧ   
	var flag1 = ev.keyCode == 8 && (t == "password" || t == "text" || t == "textarea") && (vReadOnly == true || vDisabled == true);  
	//����Backspace��ʱ���¼�Դ���ͷ�������С������ı��ģ����˸��ʧЧ   
	var flag2 = ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea";  
	//�ж�   
	if (flag2 || flag1) return false;  
}  
//��ֹ���˼� ������Firefox��Opera  
document.onkeypress = forbidBackSpace;  
//��ֹ���˼�  ������IE��Chrome  
document.onkeydown = forbidBackSpace;