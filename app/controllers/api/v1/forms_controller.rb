module Api
  module V1
    class FormsController < Api::V1:BaseController
      def demo
        demo = DemoCreationService.new.call(demo_params)
        render json: demo, status: 200
      end

      private def demo_params
        params.permit(:username, :phone, :email, :utm)
      end
    end
  end
end
