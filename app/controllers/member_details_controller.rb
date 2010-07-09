require 'rubygems'
class MemberDetailsController < ApplicationController
  before_filter :require_user
   layout "common"
  # GET /member_details
  # GET /member_details.xml
  def index
    #@member_details = MemberDetail.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @member_details }
    end
  end

  # GET /member_details/1
  # GET /member_details/1.xml
  def show
    @member_detail = MemberDetail.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @member_detail }
    end
  end

  # GET /member_details/new
  # GET /member_details/new.xml
  def new
    @member_detail=MemberDetail.find_by_user_id(current_user.id)
    if @member_detail
       @gender='female'
       @gender='male' if @member_detail.gender==true
    else
      @member_detail = MemberDetail.new
    end
    lan_user=LanguagesUser.find_by_user_id(current_user.id)
    @languages=Language.all
    @selected_language = Language.find_by_id(lan_user.language_id)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @member_detail }
    end
  end

  # GET /member_details/1/edit
  def edit
    @member_detail = MemberDetail.find(params[:id])
  end
  # POST /member_details
  # POST /member_details.xml
  def create
    @language=LanguagesUser.find_by_user_id(current_user.id)
    if @language and params[:selected_language] and params[:selected_language][:id]!=""
      if @language.update_attribute(:language_id,params[:selected_language][:id])
      end
    end
    @member_detail=MemberDetail.find_by_user_id(current_user.id)
    if @member_detail
    else
      @member_detail = MemberDetail.new  
    end
    if params[:member_detail]  
        date=Date.new(params[:member_detail]["dob(1i)"].to_i,params[:member_detail]["dob(2i)"].to_i,params[:member_detail]["dob(3i)"].to_i) 
        gender=true
        gender=false if params[:member_detail][:gender]=='female'
        job_status=false
        job_status=true if params[:member_detail][:job_status]=="yes"
        work_status=false
        work_status=true if params[:member_detail][:work_status]=="yes"
    end
    flag=false
    if job_status==true and work_status == false
      if (@member_detail.update_attributes(:user_id=>current_user.id,:dob=>date,:age=>params[:member_detail][:age],:gender=>gender,:address=>params[:member_detail][:address],:qualification=>params[:member_detail][:qualification],:job_status=>job_status,:resume=>params[:member_detail][:resume],:work_status=>false,:lang_experiance=>nil,:company_name=>nil))
        flag=true
      else
        @member_detail.errors.each do |err| p err end
      end
    elsif work_status==true and job_status == true
      if (@member_detail.update_attributes(:user_id=>current_user.id,:dob=>date,:age=>params[:member_detail][:age],:gender=>gender,:address=>params[:member_detail][:address],:qualification=>params[:member_detail][:qualification],:job_status=>job_status,:resume=>params[:member_detail][:resume],:work_status=>work_status,:lang_experiance=>params[:member_detail][:lang_experiance],:company_name=>params[:member_detail][:company_name]))
        flag=true
      end
    elsif work_status==false and job_status == false
      if (@member_detail.update_attributes(:user_id=>current_user.id,:dob=>date,:age=>params[:member_detail][:age],:gender=>gender,:address=>params[:member_detail][:address],:qualification=>params[:member_detail][:qualification],:job_status=>job_status,:resume=>nil,:work_status=>false,:lang_experiance=>nil,:company_name=>nil))
       flag=true
      end
    end
    
    respond_to do |format|
      if flag
        str="MemberDetail was successfully created."
        str="Successfully Your details will send to our HR people." if job_status
        format.html { redirect_to(member_detail_path(@member_detail.id), :notice => str) }
        format.xml  { render :xml => @member_details, :status => :created, :location => @member_detail }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @member_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /member_details/1
  # PUT /member_details/1.xml
  def update
    @member_detail = MemberDetail.find(params[:id])
    respond_to do |format|
      if @member_detail.update_attributes(params[:member_detail])
        format.html { redirect_to(@member_detail, :notice => 'MemberDetail was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /member_details/1
  # DELETE /member_details/1.xml
  def destroy
    @member_detail = MemberDetail.find(params[:id])
    @member_detail.destroy

    respond_to do |format|
      format.html { redirect_to(member_details_url) }
      format.xml  { head :ok }
    end
  end
end
