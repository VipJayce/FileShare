/**
 * 增值税及附加税计算
 * amount:产品金额
 * addValueTaxRate:增值税税率
 * additionalTaxRate：附加税税率
 * */
function taxGenerate(amount,addValueTaxRate,additionalTaxRate){
	amount = new Big(amount);
	addValueTaxRate = new Big(addValueTaxRate);
	additionalTaxRate = new Big(additionalTaxRate);
	var additionalTax = (amount.times(additionalTaxRate)).toFixed(10);//附加税金额(保留三位小数)
	var addValueTax = ((amount.plus(additionalTax)).times(addValueTaxRate)).toFixed(10);//增值税金额(保留三位小数)
//	var additionalTax = (amount*additionalTaxRate).toFixed(10);//附加税金额(保留三位小数)
//   	var addValueTax = ((parseFloat(amount)+parseFloat(additionalTax))*addValueTaxRate).toFixed(10);//增值税金额(保留三位小数)
   	return [addValueTax,additionalTax];
}

//保留两位小数
function saveTwoNum(num){
	var value = (parseFloat(num)+0).toFixed(2);
	return value;
//	var value = (parseFloat(num)+0).toFixed(3);
	//return (parseFloat(value)+0).toFixed(2);
}