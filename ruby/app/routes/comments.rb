require_relative '../controllers/comment'

class CommentRoutes < Sinatra::Base
  use AuthMiddleware

  def initialize
    super
    @commentCtrl = CommentController.new
  end

  before do
    content_type :json
  end

  get('/') do
    summary = @commentCtrl.get_batch
    
    if summary[:ok]
      { comments: summary[:data] }.to_json
    else
      { msg: 'Could not get comments.' }.to_json
    end
  end

  get('/:id') do
    comment = @commentCtrl.get_comment params['id']

    if comment[:ok]
      { comment: comment[:data] }.to_json
    else
      { msg: 'Could not get comment.' }.to_json
    end
  end

  post('/') do
    request.body.rewind
    payload = JSON.parse(request.body.read)
    summary = @commentCtrl.create_comment(payload)

    if summary[:ok]
      { msg: 'Comment created' }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  put('/:id') do
    request.body.rewind
    payload = JSON.parse(request.body.read)
    summary = @commentCtrl.update_comment params['id'], payload

    if summary[:ok]
      { msg: 'Comment updated' }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  delete('/:id') do
    summary = @commentCtrl.delete_comment params['id']

    if summary[:ok]
      { msg: 'Comment deleted' }.to_json
    else
      { msg: 'Comment does not exist' }.to_json
    end
  end
end
