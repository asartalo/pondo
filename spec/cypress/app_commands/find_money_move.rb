ledger = Ledger.find(params[:ledger_id]);
move_type = params[:type_class]
	.constantize
	.where(ledger: ledger, name: params[:move_type])
	.first
search = { money_move_type_id: move_type.id }.merge(
	params.permit(:amount, :notes, :date)
)
ledger
	.send(:"#{params[:kind]}s")
	.find_by(search)

