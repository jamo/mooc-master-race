class LinkTmcController < ApplicationController

  skip_before_action :auth!, only: [:show]

  def show
    session[:imported_token] = params[:id] unless current_user
    @imported = ImportedUser.find_by(key: params[:id])
  end

  def create
    import = ImportedUser.find_by(key: params[:key])
    applicant = Applicant.find_by(nick: params[:login])
    if import.nil?
      flash[:error] = "Invalid TMC account. Did you take the 2016-ohjelmointi course?"
      return redirect_to :back
    end
    if applicant.nil?
      flash[:error] = "No application found. Did you copypaste the link properly?"
      return redirect_to :back
    end

    if !applicant.imported_user.nil?
      return redirect_to link_tmc_path(params[:key]), notice: "TMC account was already linked."
    end

    login = params[:login]
    password = params[:password]
    auth = {username: login, password: password }
    url = "https://tmc.mooc.fi/mooc/courses.json?api_version=7"
    resp = HTTParty.get(url, basic_auth: auth, timeout: 300)
    if resp.code == 200
      applicant.transaction do
        import.transaction do
          imported.applicant = applicant
          applicant.phone_number = imported.phone
          imported.save!
          applicant.save!
        end
      end
      return redirect_to link_tmc_path(params[:key]), notice: "TMC account was linked successfully."
    else
      flash[:error] = "Username and/or password mismatch"
      return redirect_to :back
    end
  end

end
