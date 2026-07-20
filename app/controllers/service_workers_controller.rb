class ServiceWorkersController < ApplicationController
  allow_unauthenticated_access only: :show
  skip_forgery_protection only: :show

  def show
    skip_authorization
    response.headers["Cache-Control"] = "no-cache"
    render template: "service_workers/show", formats: :js, content_type: "application/javascript", layout: false
  end
end
