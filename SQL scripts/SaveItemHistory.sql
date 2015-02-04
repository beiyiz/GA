USE [DevSitecore_Custom]
GO

/****** Object:  StoredProcedure [dbo].[SaveItemHistory]    Script Date: 2/1/2015 11:09:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SaveItemHistory]
	-- Add the parameters for the stored procedure here
	@ItemID varchar(50), 	
	@ChangeType varchar(50),
	@ItemHtml varchar(max) = null,
	@Revision varchar(50),
	@ProductName varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

 declare @ItemChangeId table (ID int)

 declare @existedChangeId int

 select @existedChangeId = ItemChangeId
 from [dbo].[ItemChangeHistory]
 where [ItemID] = @ItemID

 if (@existedChangeId is not null) 
 begin
	delete from [dbo].[ItemChangeDetails] where [ItemChangeId] = @existedChangeId;
	delete from [dbo].[ItemChangeHistory] where [ItemChangeId] = @existedChangeId;
 end

INSERT INTO [dbo].[ItemChangeHistory]
           ([ItemID]           
           ,[ChangeType]
           ,[ChangeDate]
		   ,[ItemHtml]
		   ,[Revision]
		   ,ProductName)
	output Inserted.ItemChangeId into @ItemChangeId
     VALUES
           (@ItemID           
           ,@ChangeType
           ,GETDATE()
		   ,@ItemHtml
		   ,@Revision
		   ,@ProductName);


declare @ChangeID int;

select @ChangeID=ID from @ItemChangeId;

return @ChangeID;

END

GO


