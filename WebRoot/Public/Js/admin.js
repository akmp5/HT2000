
function onclickInput(obj){
	obj.value = "";
}

function onblurInput(obj,value,msg,checkType,min,max){
	if(obj.value == ""){
		if(checkType == 0){//判断类型：是否为空
			if(!Boolean(value)){//没有默认值，弹出提示
				//alert(msg);
				obj.focus();
			}
		}
		obj.value = value;
	}else{
		switch(checkType){
			case 1://判断类型：输入范围是否有效
				if(obj.value < min || obj.value > max){
					alert(msg);
					obj.value = value;
				}
		}
	}
		
}
  
  