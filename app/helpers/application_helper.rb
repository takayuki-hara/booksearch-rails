module ApplicationHelper
  def page_category
    return @page_category
  end

  def bg_color
    if page_category == 'manage'
      return 'bg-danger'
    else
      return 'bg-info'
    end
  end

  def get_genres
    return [["パソコン・システム開発", "001005"],
            ["ビジネス・経済・就職", "001006"],
            ["科学・技術", "001012"],
            ["旅行・留学・アウトドア", "001007"],
            ["語学・学習参考書", "001002"],
            ["小説・エッセイ", "001004"],
            ["人文・思想・社会", "001008"],
            ["漫画（コミック）", "001001"],
            ["エンタメ・ゲーム", "001011"],
            ["ホビー・スポーツ・美術", "001009"],
            ["美容・暮らし・健康・料理", "001010"],
            ["その他", "001015"]
    ]
  end
end
