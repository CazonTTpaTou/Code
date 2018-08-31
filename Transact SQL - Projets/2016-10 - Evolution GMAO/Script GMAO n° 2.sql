USE [GMAO_DB]
GO


declare @NextAT datetime
declare @AT datetime
declare @moisAT int
declare @IndiceSaison int
Declare @datejour Datetime;

Select @datejour = getdate();

select @AT =  DATE from  dbo.ArretTechnique
WHERE EstProchain = -1

		select @NextAT = Min(AT.Date) 
		from dbo.ArretTechnique as AT
		Where AT.Date >= @DateJour;
		print @NextAT
		update dbo.ArretTechnique
		set EstProchain = 0,
			ProchainEte = 0,
			ProchainHiver = 0
		
		update dbo.ArretTechnique
		set EstProchain = -1
		Where Date = @NextAT
		
		set @moisAT = DATEPART(MONTH,@NextAT)
		
		select @IndiceSaison = NumAT from dbo.ArretTechnique
				WHERE Date = @NextAT
		
		if @moisAT = 7 OR @moisAT = 8
			BEGIN
				
				update dbo.ArretTechnique
				set ProchainEte = -1 
				WHERE NumAT = @IndiceSaison
				
				set @IndiceSaison = @IndiceSaison + 1
				
				update dbo.ArretTechnique
				set ProchainHiver = -1 
				WHERE NumAT = @IndiceSaison
			END
		
		ELSE
			BEGIN
				update dbo.ArretTechnique
				set ProchainHiver = -1 
				WHERE NumAT = @IndiceSaison	
				
				set @IndiceSaison = @IndiceSaison + 1
				
				update dbo.ArretTechnique
				set ProchainEte = -1 
				WHERE NumAT = @IndiceSaison
			END	
GO



