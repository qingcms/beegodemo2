<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>BeegoDemo后台管理</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- App favicon -->
         <link href="/static/assets/libs/select2/select2.min.css" rel="stylesheet" type="text/css" />
        <!-- DataTables -->
        <link href="/static/assets/libs/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css"/>
        <link href="/static/assets/libs/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css"/>
        <!-- Sweet Alert-->
        <link href="/static/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />
        <!-- App css -->
        <link href="/static/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="/static/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <link href="/static/assets/css/app.min.css" rel="stylesheet" type="text/css" />

         <script src="/static/assets/js/jquery.1.7.2.min.js"></script>
<style>
.topnav-menu .active a {
    border-bottom: 2px solid  #188ae2;
}
.topnav-menu .active a span{
    color: #188ae2;
    text-align: center;
}
.logo{
font-size:25px
}
</style>
    </head>

    <body>

        <!-- Begin page -->
        <div id="wrapper">

            <!-- Topbar Start -->
            <div class="navbar-custom">
                <ul class="list-unstyled topnav-menu float-right mb-0">

                {{range $index, $elem:= .TopMenu}}
                       <li class="dropdown notification-list {{$elem.active}}">
                         <a class="nav-link  mr-0 waves-effect waves-light"  href="/index/{{$elem.AuthCode}}" role="button" aria-haspopup="false" aria-expanded="false">
                               <span class="pro-user-name ml-1">{{$elem.AuthName}} </span>
                          </a>
                      </li>
                {{end}}


                    <li class="dropdown notification-list">
                        <a class="nav-link dropdown-toggle nav-user mr-0 waves-effect waves-light" data-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">

                            <span class="pro-user-name ml-1">
                               {{.userinfo.Name}} <i class="mdi mdi-chevron-down"></i>
                            </span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right profile-dropdown ">
                            <!-- item-->
                            <div class="dropdown-item noti-title">
                                <h6 class="m-0">
                                    Hello, {{.userinfo.Name}}  !
                                </h6>
                            </div>

                            <div class="dropdown-divider"></div>

                            <!-- item-->
                            <a href="/logout" class="dropdown-item notify-item">
                                <i class="dripicons-power"></i>
                                <span>退出</span>
                            </a>

                        </div>
                    </li>

                </ul>
  <ul class="list-unstyled menu-left mb-0">
                    <li class="float-left">
                        <a href="/index" class="logo">
                            <span class="logo-lg">
                               BeegoDemo后台管理
                            </span>
                            <span class="logo-sm">
                             后台
                            </span>
                        </a>
                    </li>


                </ul>

            </div>
            <!-- end Topbar -->

            <!-- ========== Left Sidebar Start ========== -->
            <div class="left-side-menu">

                <div class="slimscroll-menu">
                    <!--- Sidemenu -->
                    <div id="sidebar-menu">
                        <ul class="metismenu" id="side-menu">
                        {{range $indexleft, $leftElem:= .LeftMenu}}
                          <li >
                               {{if gt $leftElem.isSubCount  0}}
                                    <a href="javascript: void(0);">
                                        <i class="dripicons-menu"></i>
                                        <span> {{$leftElem.AuthName}} </span>
                                         <span class="menu-arrow"></span>
                                     </a>
                                     <ul class="nav-second-level" >
                                              {{range $indexleft2, $leftElem2:= $leftElem.SubList}}
                                                  <li>
                                                      <a href="{{$leftElem2.AuthUrl}}">{{$leftElem2.AuthName}} </a>
                                                  </li>
                                              {{end}}
                                      </ul>
                                 {{else}}
                                         <a href="{{$leftElem.AuthUrl}}">
                                             <i class="dripicons-menu"></i>
                                             <span> {{$leftElem.AuthName}} </span>
                                           </a>
                                  {{end}}
                              </li>
                        {{end}}
                        </ul>
                    </div>
                    <!-- End Sidebar -->
                    <div class="clearfix"></div>
                </div>
                <!-- Sidebar -left -->
            </div>
            <!-- Left Sidebar End -->
