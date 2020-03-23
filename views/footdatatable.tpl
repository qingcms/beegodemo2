


                <!-- Footer Start -->
                <footer class="footer">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12 text-center">
                                2020 © Beegodemo
                            </div>
                        </div>
                    </div>
                </footer>
                <!-- end Footer -->

            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->

        </div>
        <!-- END wrapper -->

        <script>

        function  malert(message){
                Swal.fire({type: 'info', title:"温馨提示",text:message,confirmButtonColor:"#188ae2" ,confirmButtonText: '确定'})

        }
        function  malertsuccess(message,url){
                Swal.fire({type: 'success', title:"温馨提示",text:message,confirmButtonColor:"#188ae2",confirmButtonText: '确定'}).then(function(isConfirm) {window.location.href=url });
        }

        </script>

         <!-- Vendor js -->
           <script src="/static/assets/js/vendor.min.js"></script>
           <!-- datatable js -->
           <script src="/static/assets/libs/datatables/jquery.dataTables.min.js"></script>
           <script src="/static/assets/libs/datatables/dataTables.bootstrap4.min.js"></script>
           <script src="/static/assets/libs/datatables/dataTables.responsive.min.js"></script>
           <script src="/static/assets/libs/datatables/responsive.bootstrap4.min.js"></script>

           <script src="/static/assets/libs/datatables/dataTables.buttons.min.js"></script>
           <script src="/static/assets/libs/datatables/buttons.bootstrap4.min.js"></script>
           <script src="/static/assets/libs/datatables/buttons.html5.min.js"></script>
           <script src="/static/assets/libs/datatables/buttons.flash.min.js"></script>
           <script src="/static/assets/libs/datatables/buttons.print.min.js"></script>
           <script src="/static/assets/libs/datatables/dataTables.keyTable.min.js"></script>
           <script src="/static/assets/libs/datatables/dataTables.select.min.js"></script>
           <!-- Datatables init -->
           <script src="/static/assets/js/pages/datatables.init.js"></script>
          <!-- Sweet Alerts js -->
           <script src="/static/assets/libs/sweetalert2/sweetalert2.min.js"></script>
           <!-- App js -->
           <script src="/static/assets/js/app.min.js"></script>

       </body>
   </html>