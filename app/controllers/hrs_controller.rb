class HrsController < ApplicationController
  # GET /hrs
  # GET /hrs.xml
  before_filter :get_user_ids ,:only=>[:index,:experience_list]
  before_filter :require_user
    @@per_page = 6
    @@user_ids=nil
  def get_user_ids
    curr_user_role=RolesUser.find_by_user_id(current_user.id)
    @usrs = User.find( :all, :conditions=>["id!=? and active=true",current_user.id] , :order=>"name")
    id_array=[]
    @usrs.each do |usr|
      if usr.role.id != curr_user_role.role.id
       id_array << usr.id
      end
    end
    @@user_ids= id_array * ","
  end
  
  def index
    @sno=1
    @sno=(@@per_page.to_i*params[:page].to_i)-(@@per_page.to_i-1) if params[:page] and params[:page]!=""
    #@member_details=MemberDetail.find(:all,:conditions=>["job_status=? and user_id in (#{@@user_ids})",true])
    @member_detail_freshers=MemberDetail.paginate :all,:conditions=>["job_status=? and user_id in (#{@@user_ids}) and work_status=?",true,false],:page => params[:page], :per_page => @@per_page

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @member_detail_freshers }
    end
  end
  
  def experience_list
    @sno=1
    @sno=(@@per_page.to_i*params[:page].to_i)-(@@per_page.to_i-1) if params[:page] and params[:page]!=""
    @member_detail_experiance=MemberDetail.paginate :all,:conditions=>["job_status=? and work_status=? and user_id in (#{@@user_ids})",true,true],:page => params[:page], :per_page => @@per_page
    respond_to do |format|
        format.html # experience_list.html.erb
        format.xml  { render :xml => @member_detail_experiance }
    end
  end
  # GET /hrs/1
  # GET /hrs/1.xml
  def show
    @hr = Hr.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hr }
    end
  end

  # GET /hrs/new
  # GET /hrs/new.xml
  def new
    @hr = Hr.new
      respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hr }
    end
  end

  # GET /hrs/1/edit
  def edit
    @hr = Hr.find(params[:id])
  end

  # POST /hrs
  # POST /hrs.xml
  def create
    @hr = Hr.new(params[:hr])

    respond_to do |format|
      if @hr.save
        format.html { redirect_to(@hr, :notice => 'Hr was successfully created.') }
        format.xml  { render :xml => @hr, :status => :created, :location => @hr }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hr.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hrs/1
  # PUT /hrs/1.xml
  def update
    @hr = Hr.find(params[:id])
    respond_to do |format|
      if @hr.update_attributes(params[:hr])
        format.html { redirect_to(@hr, :notice => 'Hr was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hr.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hrs/1
  # DELETE /hrs/1.xml
  def destroy
    @hr = Hr.find(params[:id])
    @hr.destroy

    respond_to do |format|
      format.html { redirect_to(hrs_url) }
      format.xml  { head :ok }
    end
  end
end
