{{template "head.tpl" .}}
            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->

            <div class="content-page">
                <div class="content">

                    <!-- Start Content-->
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box">
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">BeegoDemo</a></li>
                                              <li class="breadcrumb-item"><a href="javascript: void(0);">系统管理</a></li>
                                            <li class="breadcrumb-item active">用户管理</li>
                                        </ol>
                                    </div>
                                    <h4 class="page-title">用户管理</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                               <div class="row">
                                                          <div class="col-12">
                                                              <div class="card-box">
                                                                  <h4 class="header-title">新增/修改用户</h4>
                                                                  <p class="sub-header">
                                                                     </p>

                                                                  <form class="form-horizontal col-8" id="formdata" >
                                                                  <input type="hidden" name="Id" id="Id" value="">
                                                                         <div class="form-group row">
                                                                    <label class="col-sm-2 col-form-label" for="Name">姓名</label>
                                                                    <div class="col-sm-10">
                                                                        <input type="text" class="form-control" id="Name" name="Name" placeholder="请输入姓名" >
                                                                    </div>
                                                                </div>
                                                                      <div class="form-group row">
                                                                          <label class="col-sm-2 col-form-label" for="UserName">账号</label>
                                                                          <div class="col-sm-10">
                                                                              <input type="text" class="form-control" id="UserName" name="UserName" placeholder="请输入账号" >
                                                                          </div>
                                                                      </div>
                                                                      <div class="form-group row">
                                                                          <label class="col-sm-2 col-form-label" for="Email">邮箱</label>
                                                                          <div class="col-sm-10">
                                                                              <input type="email" id="Email" name="Email" class="form-control" placeholder="请输入邮箱">
                                                                          </div>
                                                                      </div>

                                                                      <div class="form-group row">
                                                                          <label class="col-sm-2 col-form-label"  for="Mobile">手机号码</label>
                                                                          <div class="col-sm-10">
                                                                              <input type="text" class="form-control" id="Mobile" name="Mobile" placeholder="请输入手机号码">
                                                                          </div>
                                                                      </div>
                                                                      <div class="form-group row">
                                                                          <label class="col-sm-2 col-form-label">用户状态</label>
                                                                          <div class="col-sm-10">
                                                                              <select class="form-control" id="Status" name="Status">
                                                                                  <option value="1">正常</option>
                                                                                  <option value="0">停用</option>
                                                                              </select>
                                                                          </div>
                                                                      </div>
                                                                        <button type="button" onClick="onSave()" class="btn btn-primary">提交</button>
                                                                  </form>

                                                              </div> <!-- end card-box -->
                                                          </div><!-- end col -->
                                                      </div>
                                                      <!-- end row -->

                                                      <!-- Form row -->
            </div> <!-- container -->

            </div> <!-- content -->
<script>
onGetData()
function onGetData(){
  //判断是否有ID，如果有，则根据ID获取数据
    var id="{{.id}}"
    if (id!=""){
        var formData= new FormData()
        formData.append("id",id)
      $.ajax({ url: "/user/ajaxuserinfo",
    　　　　　　type: "POST",
    　　　　　　data: formData,
    　　　　　　processData: false,
    　　　　　　contentType: false,
    　　　　　　success: function(response){
                  if(response.code!=false){
                      setForm( response)
                      $("#UserName").attr("readonly","readonly")
                  }
    　　　　　　},
               error:function(response){
                    malert("网络异常，请稍后重试")
               }
      });
  }
}

//把内容值赋值给Form表单
 function setForm (jsonValue) {
    $.each(jsonValue, function (name, ival) {
    	var $oinput =$("input[name='" + name + "']");
    	var $otext =$("textarea[name='" + name + "']");
    	var $oselect =$("select[name='" + name + "']");
    	if ($oinput.attr("type")== "radio" || $oinput.attr("type")== "checkbox"){
    		 $oinput.each(function(){
                 if(Object.prototype.toString.apply(ival) == '[object Array]'){//是复选框，并且是数组
                      for(var i=0;i<ival.length;i++){
                          if($(this).val()==ival[i])
                             $(this).attr("checked", "checked");
                      }
    	 		 }else{
                     if($(this).val()==ival)
                        $(this).attr("checked", "checked");
                 }
             });
    	}else if($otext[0] != undefined){//多行文本框
    	    $("textarea[name="+name+"]").html(ival);
    	}else if($oselect[0]!= undefined){
            $("select[name="+name+"]").val(ival);
        }else{
            $("input[name="+name+"]").val(ival);
        }

   });
};



function onSave(){
       var formData= new FormData(document.querySelector("form"));
       if(formData.get("Id")==""){
         formData.append("Action","add")
       }else{
         formData.append("Action","edit")
       }
       //验证数据是否有值
       if(formData.get("UserName")==""){
            malert("请输入您的账号")
           return false
       }
       if(formData.get("Name")==""){
               malert("请输入您的姓名")
              return false
         }

        $.ajax({ url: "/user",
        　　　　　　type: "POST",
        　　　　　　data: formData ,
        　　　　　　processData: false,
        　　　　　　contentType: false,
        　　　　　　success: function(response){
                        if(response.code==true){
                          malertsuccess(response.errmsg,"/user")
                        }else{
                          malert(response.errmsg)
                        }
        　　　　　　},
                   error:function(response){
                        malert("网络异常，请稍后重试")
                   }
        　　　　});
}


</script>

{{template "footdatatable.tpl" .}}