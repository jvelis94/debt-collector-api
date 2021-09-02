class BillsController < ApplicationController

    private

    def set_bill
        @bill = Bill.find_by(params[:id])
    end

    def bill_params
        params.require(:bill).permit(:bill_name)
    end
end
