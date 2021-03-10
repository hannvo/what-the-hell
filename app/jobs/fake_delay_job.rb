class FakeDelayJob < ApplicationJob
  queue_as :default

  def perform(result)
    sleep 8
    result.update(json: FAKEJSON)
  end
end

FAKEJSON = "{\"adult\":false,\"also_known_as\":[\"Julia Fiona Roberts\",\"Julia F. Roberts\",\"جوليا روبرتس\",\"ジュリア・ロバーツ\",\"줄리아 로버츠\",\"Джулия Робертс\",\"จูเลีย โรเบิตส์\",\"茱莉娅·罗伯茨\",\"جولیا رابرتس\",\"Τζούλια Ρόμπερτς\"],\"biography\":\"Julia Fiona Roberts (born October 28, 1967) is an American actress and producer. She established herself as a leading lady in Hollywood after headlining the romantic comedy film Pretty Woman (1990), which grossed $464 million worldwide. She has won three Golden Globe Awards, from eight nominations, and has been nominated for four Academy Awards for her film acting, winning the Academy Award for Best Actress for her performance in Erin Brockovich (2000).\\n\\nHer films have collectively brought box office receipts of over US$2.8 billion, making her one of the most bankable actresses in Hollywood. Her most successful films include Mystic Pizza (1988), Steel Magnolias (1989), Pretty Woman (1990), Sleeping with the Enemy (1991), The Pelican Brief (1993), My Best Friend's Wedding (1997), Notting Hill (1999), Runaway Bride (1999), Erin Brockovich (2000), Ocean's Eleven (2001), Ocean's Twelve (2004), Charlie Wilson's War (2007), Valentine's Day (2010), Eat Pray Love (2010), Money Monster (2016), and Wonder (2017). Roberts was nominated for the Primetime Emmy Award for Outstanding Supporting Actress in a Limited Series or Movie for her performance in the HBO television film The Normal Heart (2014). In 2018, she starred in the Prime Video psychological thriller series Homecoming.\\n\\nRoberts was the highest-paid actress in the world throughout most of the 1990s and in the first half of the 2000s. Her fee for 1990's Pretty Woman was US$300,000; in 2003, she was paid an unprecedented $25 million for her role in Mona Lisa Smile (2003). As of 2017, Roberts's net worth was estimated to be $170 million. People magazine has named her the most beautiful woman in the world a record five times.\\n\\nDescription above from the Wikipedia article Julia Roberts licensed under CC-BY-SA, full list of contributors on Wikipedia.\",\"birthday\":\"1967-10-28\",\"deathday\":null,\"gender\":1,\"homepage\":null,\"id\":1204,\"imdb_id\":\"nm0000210\",\"known_for_department\":\"Acting\",\"name\":\"Julia Roberts\",\"place_of_birth\":\"Smyrna, Georgia, USA\",\"popularity\":8.84,\"profile_path\":\"/pahtuRDpaopvO6rH1RYS2omrO8L.jpg\"}"