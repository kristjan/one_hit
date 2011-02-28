module QuipsHelper
  def form_path(quip)
    quip.new_record? ?
      site_quips_path(quip.site) :
      site_quip_path(quip.site, quip)
  end
end
