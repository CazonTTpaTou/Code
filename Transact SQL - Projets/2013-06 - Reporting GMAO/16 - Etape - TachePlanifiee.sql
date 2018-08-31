declare @DateJour datetime;
select @DateJour = GETDATE();

exec GMAO_DEV.dbo.MAJ_AT_Calendrier @DateJour;
exec GMAO_DEV.dbo.Planifier;













