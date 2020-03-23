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
                                                                    <label class="col-sm-2 col-form-label" for="RoleName">角色名称</label>
                                                                    <div class="col-sm-10">
                                                                        <input type="text" class="form-control" id="RoleName" name="RoleName" placeholder="请输入角色名称" >
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
      $.ajax({ url: "/role/ajaxroleinfo",
    　　　　　　type: "POST",
    　　　　　　data: formData,
    　　　　　　processData: false,
    　　　　　　contentType: false,
    　　　　　　success: function(response){
                  if(response.code!=false){
                      setForm( response)
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
    	var $oselect =$("select[name='" + name + "']");
    	if($oselect[0]!= undefined){
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
       if(formData.get("RoleName")==""){
            malert("请输入角色名称")
           return false
       }
        $.ajax({ url: "/role",
        　　　　　　type: "POST",
        　　　　　　data: formData ,
        　　　　　　processData: false,
        　　　　　　contentType: false,
        　　　　　　success: function(response){
                        if(response.code==true){
                          malertsuccess(response.errmsg,"/role")
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