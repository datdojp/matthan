class CarsController < AuthenticatedController

  def index
    @title = 'Danh sách xe'
    @cars = Car.where(owner_id: session[:owner]['id'])
               .includes(:driver)
               .to_a
  end

  def new
    @car = Car.new
    @title = 'Tạo mới thông tin xe'
  end

  def create
    params.permit!
    @car = Car.new(params[:car])
    @car.owner_id = session[:owner]['id']
    @car.save
    redirect_to cars_path
  end

  def edit
    @title = 'Sửa thông tin xe'
    @car = Car.where(id: params[:id]).first
    unless @car
      show_error('Không tìm thấy thông tin xe')
      redirect_to cars_path
      return
    end
  end

  def update
    car = Car.where(id: params[:id]).first
    unless car
      show_error('Xe đã bị xoá')
      redirect_to cars_path
      return
    end
    car.update_attributes(params.require(:car).permit!)
    redirect_to cars_path
  end

  def destroy
    Car.where(id: params[:id]).delete
    redirect_to cars_path
  end

end