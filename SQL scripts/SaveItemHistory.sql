USE [DevSitecore_Custom]
GO

/****** Object:  StoredProcedure [dbo].[SaveItemHistory]    Script Date: 2/1/2015 11:09:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP PROCEDURE [dbo].[SaveItemHistory]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SaveItemHistory]
	-- Add the parameters for the stored procedure here
	@ItemID varchar(50), 	
	@ItemName varchar(50), 	
	@ChangeType varchar(50),
	@ItemHtml varchar(max) = null,
	@Revision varchar(50),
	@ProductName varchar(50),
	@ProductCategory varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

 declare @ItemChangeId table (ID int)
 declare @ChangeID int;
 declare @existedChangeId int
 declare @existedChangeType varchar(50)
 declare @approvalStatus varchar(50)

 select @existedChangeId = ItemChangeId, @existedChangeType=ChangeType, @ChangeID = ItemChangeId, @approvalStatus = ApprovalStatus
 from [dbo].[ItemChangeHistory]
 where [ItemID] = @ItemID

 if (@existedChangeId is not null and (@existedChangeType = 'Update' or @approvalStatus = 'Deleted')) 
 begin
	delete from [dbo].[ItemChangeDetails] where [ItemChangeId] = @existedChangeId;
	delete from [dbo].[ItemChangeHistory] where [ItemChangeId] = @existedChangeId;
 end

  if (@existedChangeId is not null and @existedChangeType = 'Add' and @approvalStatus is null) 
	  begin
		UPDATE [dbo].[ItemChangeHistory]
		SET
			ItemName = @ItemName,
			ItemHtml = @ItemHtml
		WHERE [ItemID] = @ItemID	

		DELETE [dbo].[ItemChangeDetails]
		WHERE [ItemChangeId] = @existedChangeId AND
			  [FieldName] = 'ItemName';
	  end
  else
	  begin
			INSERT INTO [dbo].[ItemChangeHistory]
				   ([ItemID]  
				   ,ItemName         
				   ,[ChangeType]
				   ,[ChangeDate]
				   ,[ItemHtml]
				   ,[Revision]
				   ,ProductName
				   ,ProductCategory)
			output Inserted.ItemChangeId into @ItemChangeId
			 VALUES
				   (@ItemID  
				   ,@ItemName         
				   ,@ChangeType
				   ,GETDATE()
				   ,@ItemHtml
				   ,@Revision
				   ,@ProductName
				   ,@ProductCategory);

			select @ChangeID=ID from @ItemChangeId;
		end





return @ChangeID;

END

GO


