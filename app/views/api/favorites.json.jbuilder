json.array! @favorites do |favorite|
  json.user_id favorite.user_id
  json.book do
    json.id favorite.book.id
    json.title favorite.book.title
    json.price favorite.book.price
    json.genres favorite.book.genres
    json.author favorite.book.author
    json.publisher favorite.book.publisher
    json.isbn favorite.book.isbn
    json.caption favorite.book.caption
    json.sales_date favorite.book.sales_date
    json.item_url favorite.book.item_url
    json.largeimage_url favorite.book.largeimage_url
    json.created_at favorite.book.created_at
    json.updated_at favorite.book.updated_at
  end
  json.created_at favorite.created_at
  json.updated_at favorite.updated_at
end
