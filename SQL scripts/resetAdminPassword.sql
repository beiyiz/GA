UPDATE [aspnet_Membership] SET Password='qOvF8m8F2IcWMvfOBjJYHmfLABc='   
WHERE UserId IN (SELECT UserId FROM [aspnet_Users] WHERE UserName = 'sitecore\Admin')


select * from  [aspnet_Membership] WHERE UserId IN (SELECT UserId FROM [aspnet_Users] WHERE UserName = 'sitecore\Admin')