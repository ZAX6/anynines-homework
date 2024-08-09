class CommentController
  def create_comment(comment)
    comment_not_exists = ! (Comment.exists?(:title => comment['title']))

    return { ok: false, msg: 'Comment with given title already exists' } unless comment_not_exists

    new_comment = Comment.new(:article_id => comment['article_id'], :content => comment['content'], :created_at => Time.now, :author_name => comment['author_name'])
    new_comment.save

    { ok: true, obj: comment }
  rescue StandardError
    { ok: false }
  end

  def update_comment(id, new_data)

    comment = Comment.find(id)

    return { ok: false, msg: 'Comment could not be found' } unless comment

    comment.article_id = new_data['article_id']
    comment.content = new_data['content']
    comment.author_name = new_data['author_name']
    comment.save

    { ok: true , obj: comment}
  rescue StandardError
    { ok: false, msg: 'Update request on a non-existing object' }
  end

  def get_comment(id)
    res = Comment.find(id)
    if res
      { ok: true, data: res }
    else
      { ok: false, msg: 'Comment not found' }
    end
  rescue StandardError
    { ok: false }
  end

  def delete_comment(id)
    delete_count = Comment.destroy_by(:id => id).count

    if delete_count == 0
      { ok: false }
    else
      { ok: true, delete_count: delete_count }
    end
  rescue StandardError
    { ok: false }
  end

  def get_batch
    res = Comment.all

    if !res.empty?
      { ok: true, data: res }
    else
      { ok: false, msg: 'Query Failed. Possibly empty database' }
    end
  rescue StandardError
    { ok: false }
  end
end
