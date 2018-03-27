module Api
  module V1
    class FormsController < Api::V1::BaseController
      def demo
        demo = DemoCreationService.new
        demo.auth
        response = demo.create_lead(demo_params)
        render json: response, status: 200
      end

      private def demo_params
        params.permit(:username, :phone, :email, :utm)
      end
    end
  end
end
