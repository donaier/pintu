class WelcomeController < ApplicationController
  before_action :authenticate_user!

  require 'rqrcode'

  def index
    qrcode = RQRCode::QRCode.new(current_user.otp_provisioning_uri('pintu', issuer: "pintu:#{current_user.email}"))

    # NOTE: showing with default options specified explicitly
    @svg = qrcode.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 6,
      standalone: true
    )
  end
end
