USE DB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


IF OBJECT_ID('schema.BorrowingsManager','P') IS NOT NULL
	DROP PROCEDURE schema.BorrowingsManager
GO

CREATE PROCEDURE schema.BorrowingsManager
	@ID_User INT = NULL, 
	@ID_Book INT = NULL,
	@ResultSP VARCHAR(MAX) OUTPUT

AS
BEGIN

	SET NOCOUNT ON

	BEGIN TRY

	IF @ID_Book IS NOT NULL AND @ID_User IS NOT NULL
	BEGIN

		IF NOT EXISTS (SELECT NULL FROM schema.Books WHERE ID = @ID_Book) OR NOT EXISTS (SELECT NULL FROM schema.Users WHERE ID = @ID_User)
		BEGIN

			SET @ResultSP = 'Book or User or both not in the database ' + ERROR_MESSAGE()
			PRINT @ResultSP
			RETURN

		END

		IF EXISTS (SELECT NULL FROM schema.Borrowings WHERE ID_Book = @ID_Book AND ID_User = @ID_User)
		BEGIN

			SET @ResultSP = 'Book already borrowed by this user ' + ERROR_MESSAGE()
			PRINT @ResultSP
			RETURN

		END

		IF (SELECT COUNT(*) FROM schema.Borrowings WHERE ID_User = @ID_User GROUP BY ID_User) >= 5
		BEGIN

			SET @ResultSP = 'This user has borrowed too many books ' + ERROR_MESSAGE()
			PRINT @ResultSP
			RETURN

		END

		IF (SELECT Quantity FROM schema.Books WHERE ID = @ID_Book) <= 0
		BEGIN

			SET @ResultSP = 'No copies available to borrow for this book ' + ERROR_MESSAGE()
			PRINT @ResultSP
			RETURN

		END

		-- I insert the borrowing to the database table
		INSERT INTO schema.Borrowings(ID_Book,
								   ID_User,
								   BorrowingStartDate,
								   BorrowingEndDate,
								   Active)
		VALUES
		(@ID_Book,
		 @ID_User,
		 CAST(GETDATE() AS DATE),
		 DATEADD(month, 2, CAST(GETDATE() AS DATE)),
		 1)

		-- I subtract the borrowed copy to the table field Quantity
		UPDATE schema.Books SET Quantity = Quantity -1
		WHERE ID = @ID_Book

	END
	ELSE
	BEGIN

	--Check mode, it will return the list of borrowings ending in the next 7 days
		SELECT *
		FROM schema.Borrowings
		WHERE BorrowingEndDate BETWEEN CAST(GETDATE() AS DATE) AND DATEADD(day, 7, CAST(GETDATE() AS DATE))

	END

	RETURN

	END TRY

	BEGIN CATCH

		SET @ResultSP = 'SP schema.BorrowingsManager KO ' + ERROR_MESSAGE()
		PRINT @ResultSP
		RETURN

	END CATCH

END
