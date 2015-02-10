<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="mylan_institutional_products.Admin.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/bootstrap-theme.min.css" />
    <script type="text/javascript" src="scripts/jquery-2.1.3.min.js"></script>   
    <script type="text/javascript" src="scripts/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container" style="margin-top:40px">
		<div class="row">
			<div class="col-sm-6 col-md-4 col-md-offset-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<strong> Sign in to continue</strong>
					</div>
					<div class="panel-body">
						
						<fieldset>

							<div class="row">
								<div class="col-sm-12 col-md-10  col-md-offset-1 ">
									<div class="form-group">
										<div class="input-group">
											<span class="input-group-addon">
												<i class="glyphicon glyphicon-user"></i>
											</span> 
											<input class="form-control" placeholder="Username" id="loginName" type="text" autofocus runat="server">
										</div>
									</div>
									<div class="form-group">
										<div class="input-group">
											<span class="input-group-addon">
												<i class="glyphicon glyphicon-lock"></i>
											</span>
											<input class="form-control" placeholder="Password" id="loginPassword" type="password" value="" runat="server">
										</div>
									</div>
                                    <div class="form-group"><span class="text-danger" id="errorMsg" runat="server"></span></div>
									<div class="form-group">
										<input type="submit" class="btn btn-lg btn-primary btn-block" value="Sign in">
									</div>
								</div>
							</div>
						</fieldset>
						
					</div>
					
                </div>
			</div>
		</div>
	</div>
    </form>
</body>
</html>
