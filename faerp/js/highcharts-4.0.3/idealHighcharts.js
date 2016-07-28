//统计图的触发绑定与整理  
var MyHighcharts = function(outOptions){
	//临时highcharts对象
    var tempHighcharts = this;
    var _column;
    var _line;
    //(y轴或x轴)类别名称
    var categoriesLocal = [2002,2003,2004,2005,2006,2007,2008];
    //基础参数
    var defaults = {
    	yRotation:0,//旋转角度
    	xRotation:0,//旋转角度
    	yUnit:'',//y转度量单位
        title:"",//默认标题  
        layout: 'horizontal',//legend布局方式 水平还是垂直layout: 'vertical', 默认水平
        align: 'center',//legend水平对齐方式align:right
        verticalAlign: 'bottom',//legend垂直对齐方式verticalAlign: 'middle'
        subTitle:"",  //这是默认副标题
        xTitle:"",  //x轴说明
        yTitle:"",  //y轴说明  
        chartType:2,//图表类型 默认图表为线性图
        renderTo:'container',//div id 需要渲染的DIV
        url:'',	  //ajax URL
        param:'',  //ajax 參數
        type:'POST',   //ajax type 默认ajax POST请求方式
        datatype:'json'	   //ajax 服务器返回数据类型
    };
    //将outOptions中的对象内容合并到defaults中
    var myOptions = $.extend(defaults, outOptions);
    
    /** 发起ajax请求，调用回调函数进行图表绘制*/  
    this.draw = function(newOptions){
    	myOptions = $.extend(defaults, newOptions);
		$.ajax({
		  type : myOptions.type,
			url : myOptions.url,
			data : myOptions.param,
			datatype : myOptions.datatype,
			success : this.callBackChart//回调函数
		});
    };
     
    /** 返回数据处理 */  
    this.callBackChart = function(data){  
        switch (myOptions.chartType) {
        case 0://线状图  
            _line = tempHighcharts.callBackLine(data);  
            break;  
        case 1://柱状图  
        	_column = tempHighcharts.callBackColumn(data);  
        	break;
        case 5://base柱状图  
            _column = tempHighcharts.callBackBaseColumn(data);  
            break;
        case 2://单饼图  
        	tempHighcharts.callBackPie(data);  
        	break;
        case 11://分组柱状图
        	tempHighcharts.callBackGroupColumn(data);  
        	break;
        case 4://分组柱状图
            tempHighcharts.callBackFunnel(data);  
            break;
        default://内嵌饼图
            //tempHighcharts.setClass(2);  
            //tempHighcharts.callBackDonutPie(data);  
            break;  
        }  
    };
      
    // line请求返回函数的处理  
    this.callBackLine = function(data){  
        var line = new Highcharts.Chart({
            chart: {  
                renderTo: myOptions.renderTo,
                type: 'line'  
            },  
            title: {  
                text: myOptions.title
            },  
            subtitle: {  
                text: myOptions.subtitle
            },
            labels:{
                formatter: function() { //格式化标签名称 
                return this.value + data.rows[0].yUnit;
                }
            },
            credits:{
                enabled:false
            },
            exporting: {
                enabled: false
            },
            xAxis: {  
                title: {  
                    text: myOptions.xTitle,
                    align: 'high'  
                },
                labels: {
                    rotation: myOptions.xRotation,
                    align: 'right',
                    style: {
                        fontSize: '13px',
                        fontFamily: 'Verdana, sans-serif'
                    }
                },
                categories: data.rows[0].categories
            },  
            yAxis: {  
                title: {  
                    align: 'high',  
                    offset: 0,  
                    text: myOptions.yTitle,
                    rotation: myOptions.yRotation,  
                    y: -10  
  
                },
                min:myOptions.min,
                labels:{
                    formatter: function() { //格式化标签名称 
                    return this.value + data.rows[0].yUnit;
                    }
                },
                plotLines: [{  
                    value: 0,  
                    width: 1,  
                    color: '#808080'  
                }]  
            },  
            plotOptions: {
            	/**series: {
                    events: {
                        legendItemClick: function(event) {
                            return false;
                        }
                    }
                },**/
                spline: {  
                    marker: {  
                        radius: 4,  
                        lineColor: '#666666',  
                        lineWidth: 1  
                    }  
                }
                
            },  
            legend:{  
            	layout: myOptions.layout,
                align: myOptions.align,
                verticalAlign: myOptions.verticalAlign,
                borderWidth:0  
            },  
            tooltip: {  
                crosshairs: true,
                shared: true,
                formatter: function() {  
                    var s = '<b>'+ this.x +'</b>';
                    
                    $.each(this.points, function(i, point) {
                        s += '<br/>'+ point.series.name +': '+
                        tempHighcharts.isContains_present(data.rows[0].yUnit,point.y) + data.rows[0].yUnit;
                    });
                    
                    return s;
                } 
                  
            },  
            series: data.rows[0].lineAndColumn
        });
        return line;
    };  
    // column请求返回函数的处理(分段柱状图)
    this.callBackGroupColumn = function(data){
    	var groupColumn = new Highcharts.Chart({  
    		chart: {  
    			renderTo: myOptions.renderTo,
    			stacking: 'percent',
    			type: 'column'
    		},  
    		title: {  
    			text: myOptions.title//tempHighcharts.getTimeTitle(tempChart.categoriesLocal)  
    		},
    		labels:{
    			formatter: function() { //格式化标签名称 
    				return this.value + myOptions.yUnit;
    			}
    		},
    		credits:{
    			enabled:false
    		},
    		exporting: {
    			enabled: false
    		},
    		subtitle: {  
    			text: myOptions.subtitle  
    		},  
    		xAxis: {  
    			title: {  
    				text: myOptions.xTitle,  
    				align: 'high'  
    			},
    			labels: {
    				rotation: myOptions.xRotation,
    				//align: 'center',
    				style: {
    					fontSize: '13px',
    					fontFamily: 'Verdana, sans-serif'
    				}
    			},
    			categories: data.rows[0].categories
    		},  
    		yAxis: {  
    			title: {  
    				align: 'high',  
    				offset: 0,  
    				text: myOptions.yTitle,  
    				rotation: myOptions.yRotation,  
    				y: -10  
    				
    			},
    			labels:{
    				formatter: function() { //格式化标签名称 
    					return this.value + myOptions.yUnit;
    				}
    			},
    			stackLabels: {
                     enabled: true,
                     style: {
                         fontWeight: 'bold',
                         color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                         
                     },
                     formatter:function(){
                         return this.total;
                     }
                 } 
    		},
    		plotOptions: {
    			/** 柱状图单击事件 **/
                column: {
                	/*
                	cursor: 'pointer',
                	point: {
                        events: {
                            click: function() {
                            	//var _this = this;
                            	//alert(this.options.url);
                            	if(this.options.url != null && this.options.url != undefined && this.options.url != ''){
                            		location.href = this.options.url;
                            	}
                            }
                        }
                    },
                    */
                    stacking: 'percent',
                    dataLabels: {
                        formatter:function(){
                            return this.y>0?tempHighcharts.isContains_present(myOptions.yUnit,this.percentage) + '%' :null;
                        },
                        enabled: true,
                        color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
                    }
                }
            },
    		  
    		legend:{
    			//align: 'right',
                //x: -70,
                //verticalAlign: 'top',
                //y: 20,
                //floating: true,
                backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false 
    		},  
    		/*
    		tooltip: {
    			formatter: function() {
                    return '<b>'+ this.x +'</b><br/>'+
                        this.series.name +': '+ tempHighcharts.isContains_present(myOptions.yUnit,this.y) +'<br/>'+
                        'Total: '+ this.point.stackTotal;
                }
    		},
    		*/
    		tooltip: {
                pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.1f}%)<br/>',
                shared: true
            },
    		series:data.rows[0].lineAndColumn
    	});
    	return groupColumn;
    }; 
    // column请求返回函数的处理(普通柱状图)
    this.callBackFunnel = function(data){
    	var funnel = new Highcharts.Chart({
    		chart: {
    			renderTo: myOptions.renderTo,
                type: 'funnel'//,
                //marginRight: 100
            },
            credits:{
    			enabled:false
    		},
    		exporting: {
    			enabled: false
    		},
            title: {
                text: 'Sales funnel',
                x: -50
            },
            plotOptions: {
                series: {
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b> ({point.y:,.0f})',
                        color: 'black',
                        softConnector: true
                    },
                    neckWidth: '0%',
                    neckHeight: '15%'
                    
                    //-- Other available options
                    // height: pixels or percent
                    // width: pixels or percent
                }
            },
            legend: {
                enabled: false
            },
            series: [{
                name: 'Unique users',
                data: [
                    ['Website visits',   15654],
                    ['Downloads',       4064],
                    ['Requested price list', 1987],
                    ['Invoice sent',    976],
                    ['Finalized',    846]
                ]
            }]
    	});
    	return funnel;
    };  
    // column请求返回函数的处理(普通柱状图)
    this.callBackBaseColumn = function(data){
    	var baseColumn = new Highcharts.Chart({
            chart: {
            	renderTo: myOptions.renderTo,
                type: 'column'
            },
            credits:{
                enabled:false
            },
            exporting: {
                enabled: false
            },
            title: {
                text: myOptions.title
            },
            subtitle: {
                text: myOptions.subtitle
            },
            xAxis: {
                categories: data.rows[0].categories
            },
            yAxis: {
                min: myOptions.min,
                title: {
                    text: myOptions.yTitle
                },
                title: {  
                    align: 'high',  
                    offset: 0,  
                    text: myOptions.yTitle,  
                    rotation: myOptions.yRotation,  
                    y: -10  
  
                },
                labels:{
                    formatter: function() { //格式化标签名称 
                    	return this.value + data.rows[0].yUnit;
                    }
                },
                plotLines: [{  
                    value: 0,  
                    width: 1,  
                    color: '#808080'  
                }] 
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y:.1f}' + data.rows[0].yUnit + '</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: data.rows[0].lineAndColumn
        });
    	return baseColumn;
    },
    // column请求返回函数的处理(普通柱状图)
    this.callBackColumn = function(data){
        var column = new Highcharts.Chart({  
            chart: {  
                renderTo: myOptions.renderTo,
                type: 'column'
            },  
            title: {  
                text: myOptions.title//tempHighcharts.getTimeTitle(tempChart.categoriesLocal)  
            },
            labels:{
                formatter: function() { //格式化标签名称 
                return this.value + data.rows[0].yUnit;
                }
            },
            credits:{
                enabled:false
            },
            exporting: {
                enabled: false
            },
            subtitle: {  
                text: myOptions.subtitle  
            },  
            xAxis: {  
                title: {  
                    text: myOptions.xTitle,  
                    align: 'high'  
                },
                labels: {
                    rotation: myOptions.xRotation,
                    align: 'center',
                    style: {
                        fontSize: '13px',
                        fontFamily: 'Verdana, sans-serif'
                    }
                },
                categories: data.rows[0].categories  
            },  
            yAxis: {  
                title: {  
                    align: 'high',  
                    offset: 0,  
                    text: myOptions.yTitle,  
                    rotation: myOptions.yRotation,  
                    y: -10  
  
                },
                labels:{
                    formatter: function() { //格式化标签名称 
                    return this.value + data.rows[0].yUnit;
                    }
                },
                plotLines: [{  
                    value: 0,  
                    width: 1,  
                    color: '#808080'  
                }]  
            },
            
            plotOptions: {
            	series: {
                    
                    /** 柱状图单击事件 **/
                    cursor: 'pointer',
                    point: {
                        events: {
                            click: function() {
                            	return false;
                            	//var _this = this;
                            	//alert(this.options.url);
                            	/*if(this.options.url != null && this.options.url != undefined && this.options.url != ''){
                            		location.href = this.options.url;
                            	}*/
                            }
                        }
                    }
                },
                
                spline: {  
                    marker: {  
                        radius: 4,  
                        lineColor: '#666666',  
                        lineWidth: 1  
                    }  
                }  
            },  
            legend:{  
                borderWidth:0,
                enabled:false
            },  
            tooltip: {
                formatter: function() {  
                    return ''+this.x+'<br/>'+  
                    this.series.name +': '+ tempHighcharts.isContains_present(data.rows[0].yUnit,this.y) + data.rows[0].yUnit;  
                }
            },  
            series: data.rows[0].lineAndColumn
        });
        return column;
    };
    // 单饼状图  
    this.callBackPie = function(data){  
        var pie = new Highcharts.Chart({  
            chart: {
                renderTo: myOptions.renderTo,
                plotBackgroundColor: null,  
                plotBorderWidth: null,  
                plotShadow: false,  
                type:'pie'  
            },
            labels:{
                formatter: function() { //格式化标签名称 
                return this.value + data.rows[0].yUnit;
                }
            },
            credits:{
                enabled:false
            },
            exporting: {
                enabled: false
            },
            title: {  
                text: myOptions.title//tempHighcharts.getTimeTitle(tempChart.categoriesLocal)  
            },  
            subtitle: {  
                text: myOptions.subtitle
            },  
            
            tooltip: {  
                formatter: function() {  
                    return '<b>'+ this.point.name +'</b>: '+ Highcharts.numberFormat(this.percentage, 1) +' %';  
                }  
            }, 
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    animation:true,
                    cursor: 'pointer',  
                    dataLabels: {
                    	style: {
                            fontSize: '10px',
                            fontFamily: 'Arial, 宋体'
                        },
                        enabled: true,  
                        color: '#000000',
                        distance:5,
                        connectorColor: '#000000',  
                        formatter: function() {  
                            return '<b>'+ this.point.name +'</b>: ' + Highcharts.numberFormat(this.percentage, 1)+ '%' +'<br/>'+ this.y + data.rows[0].yUnit ;  
                        }  
                    },
            		showInLegend: true,
            		point: {
                        events: {
                            legendItemClick: function () {
                                return false; // <== returning false will cancel the default action
                            }
                        }
                    }
                }  
            },
            legend: {
            	itemMarginTop: 2,
                itemMarginBottom: 2,
            	itemStyle: {
            		fontSize: '10px',
            		fontFamily: 'Arial, 宋体',
            		fontWeight: 'bold'
            	}
            },
            series: data.rows[0].pie
        });  
        return pie;
    };
    this.isContains_present = function(yunit,y){
    	if(yunit!='%'){
    		return y;
    	}else{
    		return Highcharts.numberFormat(y, 1);
    	}
    };
};  