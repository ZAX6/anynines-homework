class ArticleController
  def create_article(article)
    article_not_exists = ! (Article.exists?(:title => article['title']))

    return { ok: false, msg: 'Article with given title already exists' } unless article_not_exists

    new_article = Article.new(:title => article['title'], :content => article['content'], :created_at => Time.now)
    new_article.save

    { ok: true, obj: article }
  rescue StandardError
    { ok: false }
  end

  def update_article(id, new_data)

    article = Article.find(id)

    return { ok: false, msg: 'Article could not be found' } unless article

    article.title = new_data['title']
    article.content = new_data['content']
    article.save

    { ok: true , obj: article}
  rescue StandardError
    { ok: false, msg: 'Update request on a non-existing object' }
  end

  def get_article(id)
    res = Article.find(id)
    if res
      { ok: true, data: res }
    else
      { ok: false, msg: 'Article not found' }
    end
  rescue StandardError
    { ok: false }
  end

  def delete_article(id)
    delete_count = Article.destroy_by(:id => id).count

    if delete_count == 0
      { ok: false }
    else
      { ok: true, delete_count: delete_count }
    end
  rescue StandardError
    { ok: false }
  end

  def get_batch
    res = Article.all

    if !res.empty?
      { ok: true, data: res }
    else
      { ok: false, msg: 'Query Failed. Possibly empty database' }
    end
  rescue StandardError
    { ok: false }
  end
end
