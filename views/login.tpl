<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>BeegoDemo登录页</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="BeegoDemo" name="description" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- App favicon -->

        <!-- App css -->
        <link href="/static/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="/static/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <link href="/static/assets/css/app.min.css" rel="stylesheet" type="text/css" />

    </head>

    <body class="authentication-bg authentication-bg-pattern d-flex align-items-center">

        <div class="home-btn d-none d-sm-block">
        </div>

        <div class="account-pages w-100 mt-5 mb-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-8 col-lg-6 col-xl-5">
                        <div class="card">

                            <div class="card-body p-4">

                                <div class="text-center mb-4">
                                    <a href="/login">
                                        <span>BeegoDemo</span>
                                    </a>
                                </div>

                                <form action="/login" class="pt-2" >

                                    <div class="form-group mb-3">
                                        <label for="username">账号</label>
                                        <input class="form-control" type="text" id="username" required="" placeholder="请输入您的账号">
                                    </div>

                                    <div class="form-group mb-3">
                                        <label for="password">密码</label>
                                        <input class="form-control" type="password" required="" id="password" placeholder="请输入密码">
                                    </div>

                                    <div class="custom-control custom-checkbox mb-3">
                                    </div>

                                    <div class="form-group mb-0 text-center">
                                        <button class="btn btn-info btn-block" id="login_button" type="button" onclick="login()"> 登录 </button>
                                    </div>

                                </form>

                                <div class="row mt-3">
                                    <div class="col-12 text-center">
                                    </div> <!-- end col -->
                                </div>
                                <!-- end row -->

                            </div> <!-- end card-body -->
                        </div>
                        <!-- end card -->

                    </div> <!-- end col -->
                </div>
                <!-- end row -->
            </div>
            <!-- end container -->
        </div>
        <!-- end page -->
        <!-- Vendor js -->
        <script src="/static/assets/js/vendor.min.js"></script>
        <!-- App js -->
        <script src="/static/assets/js/app.min.js"></script>
        <script src="/static/assets/js/jquery.1.7.2.min.js"></script>

<script>

function login() {
	var pre_submit = '登录', done_submit = '登录中...';
	var username = $('#username').val();
	var password = $('#password').val();
	$('#login_button').text(done_submit);

	// check
	if ('' == username || '' == password) {
	    $('#login_button').text(pre_submit);
		alert('您输入的帐号或密码错误，请重新输入！');
		return false;
	}

	var data = {
		username : username,
		password : password
	};
	$.post("/login", data, function(rs) {
		//判断跳转页面
		if (rs.status == true) {
			location.href = "/index";
		}else {
			$('#login_button').text(pre_submit);
			alert(rs.msg);
		}
	}, 'json');
}
</script>

    </body>
</html>