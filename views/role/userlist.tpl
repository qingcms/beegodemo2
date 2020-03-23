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
                                            <li class="breadcrumb-item active">角色用户管理</li>
                                        </ol>
                                    </div>
                                    <h4 class="page-title">角色用户管理</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

   <div class="row">

                              <div class="col-12">
                                  <div class="card-box">
                                      <h4 class="header-title"></h4>
                                      <p class="sub-header">

                                              <button type="button" class="btn btn-primary waves-effect waves-light width-md" data-toggle="modal" data-target=".bs-example-modal-lg">新增</button>
                                              <button type="button" onclick="onDelete()" class="btn btn-danger waves-effect waves-light width-md">删除</button>
                                      </p>

                                      <table id="userlist" class="table table-bordered dt-responsive nowrap">
                                          <thead>
                                          <tr>
                                              <th>#</th>
                                              <th>序号</th>
                                              <th>账号</th>
                                              <th>姓名</th>
                                              <th>手机号码</th>
                                              <th>邮箱</th>
                                              <th>状态</th>
                                          </tr>
                                          </thead>
                                          <tbody>

                                          </tbody>
                                      </table>



                                  </div>
                              </div>
                          </div> <!-- end row -->
                        <!-- end row-->
                             <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="display: none;">
                                                              <div class="modal-dialog modal-lg">
                                                                  <div class="modal-content">
                                                                      <div class="modal-header">
                                                                          <h4 class="modal-title" id="myLargeModalLabel">新增角色用户</h4>
                                                                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                      </div>
                                                                      <div class="modal-body">
                                                  <form class="form-horizontal col-8" id="formdata" >
                                                                  <input type="hidden" name="RoleId" id="RoleId" value="">
                                                                   <div class="form-group row">
                                                                           <label class="col-sm-2 col-form-label">用户</label>
                                                                           <div class="col-sm-10">
                                                                               <select class="form-control" id="UserId" name="UserId">

                                                                               </select>
                                                                           </div>
                                                                       </div>
                                                     <button type="button" onClick="onSaveRoleUser()" class="btn btn-primary">提交</button>
                                                  </form>
                                                                      </div>
                                                                  </div><!-- /.modal-content -->
                                                              </div><!-- /.modal-dialog -->
                                                          </div><!-- /.modal -->

                    </div> <!-- container -->

                </div> <!-- content -->


<script>

var roleid="{{.roleid}}"
getUserList()

function getUserList(){
var data={}
$.post("/user/ajaxuser", data, function(res) {
  if(res.code==false){
       alert("加载数据失败");
  }else{
      var tbodyHtml=""
      $.each(res,function(index,row){
            tbodyHtml +="<option value='"+row.Id+"'>"+row.Name+"</option>"
      })
      $("#UserId").html(tbodyHtml)
  }
});
}

function onAdd(){
  window.location.href="/role/add"
}

function onEdit(){
   var checks=getCheckBoxVal()
    if(checks.length==0){
       malert("请选择一条记录");
       return false
    }
      if(checks.length>1){
           malert("您选择了多条数据，只能选择一条数据");
           return false
      }

  window.location.href="/user/edit/"+checks[0]
}



//jquery获取所有选中的复选框的值
function getCheckBoxVal(){
    var chk_value =[];
    //遍历，将所有选中的值放到数组中
    $("#userlist").find('input[name="userid"]:checked').each(function(){
        chk_value.push($(this).val());
    });
    return chk_value;
}

function onDelete(){
//弹出提示语
  mconfirm("确定要删除选中数据吗？",exeDelete)
}

function exeDelete (){
 var checks=getCheckBoxVal()
    if(checks.length==0){
       malert("请选择一条记录");
       return false
    }
  var ids="";
   $.each(checks,function(index,value){
            if(ids==""){   ids+=value
            }else{  ids+=","+value
            }
   })
  var formData= new FormData()
       formData.append("UserId",$("#UserId").val())
       formData.append("RoleId",$("#RoleId").val())
       formData.append("Action","add")
         $.ajax({ url: "/role/roleuser",
       　　　　　　type: "POST",
       　　　　　　data: formData,
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

function onSaveRoleUser(){
  var formData= new FormData()

          formData.append("UserId",$("#UserId").val())
          formData.append("RoleId",roleid)
          formData.append("Action","add")
         $.ajax({ url: "/role/roleuser",
       　　　　　　type: "POST",
       　　　　　　data: formData,
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


function mconfirm(message,callback){

 Swal.fire({type: 'warning', title:"温馨提示",text:message,confirmButtonColor:"#188ae2",
    showCancelButton: true,
    cancelButtonColor: '#d33',
    confirmButtonText: '确定',
    showCancelButton: true,
    cancelButtonColor: '#d33',
    cancelButtonText: "取消"
 }).then(function(isConfirm) {
     console.log(isConfirm)
     if(isConfirm.value){
        if (typeof callback === "function"){
          callback();
        }
     }
  });
}





</script>

{{template "footdatatable.tpl" .}}
