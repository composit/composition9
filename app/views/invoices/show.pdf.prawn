pdf.font "Helvetica", :style => :bold
pdf.text "Composition9 Design, LLC", :size => 24
pdf.text "1625 W. Elizabeth, #H-6", :size => 8
pdf.text "Fort Collins, CO  80521", :size => 8
pdf.text "matt@composition9.com", :size => 8
pdf.text "(970) 310-4329", :size => 8

pdf.text "
" + @invoice.client.name

pdf.text "Invoice #" + @invoice.invoice_number
pdf.text @invoice.invoice_date.strftime('%m-%d-%Y') + "
 "
@invoice.projects.each do |project|
  pdf.text project.title + ": " + one_dec(@invoice.project_details( project.id )[:hours]).to_s + " hours"
end
@invoice.invoice_adjustment_lines.each do |invoice_adjustment_line|
  pdf.text invoice_adjustment_line.description + ": " + number_to_currency(invoice_adjustment_line.amount)
end
pdf.text "
TOTAL: " + number_to_currency(@invoice.total_amount), :size => 18
