import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String articleId;
  final String articleTitle;
  final String articleSubtitle;
  final String articleBody;
  final String articleAuthor;
  final String articleAuthorImageUrl;
  final String articleCategory;
  final String articleImageUrl;
  final List<String> articleArrayImageUrl;
  final int articleViews;
  final DateTime createdAt;

  const Article(
      {required this.articleId,
      required this.articleTitle,
      required this.articleSubtitle,
      required this.articleBody,
      required this.articleAuthor,
      required this.articleAuthorImageUrl,
      required this.articleCategory,
      required this.articleImageUrl,
      required this.articleArrayImageUrl,
      required this.articleViews,
      required this.createdAt});

  static List<Article> articles = [
    Article(
      articleId: '1',
      articleTitle: 'Thông tin cơ bản về skincare',
      articleSubtitle:
          'Có lẽ ngày nay việc chăm sóc da mỗi ngày dường như đã trở thành một thói quen của phái đẹp. Việc skincare mỗi ngày sẽ giúp làn da mịn màng, đầy sức sống hơn, giảm thiểu các vấn đề về da do các yếu tố bên ngoài. Vậy các bước skincare như thế nào để việc chăm sóc da đạt hiệu quả cao? Hãy cùng Miên Spa tìm hiểu về cách lựa chọn sản phẩm phù hợp cho da và các bước skincare cơ bản nhé!',
      articleBody:
          'Lựa chọn sản phẩm phù hợp cho da\n\n\n1. Lưu ý khi lựa chọn sản phẩm\nĐối với người mới bắt đầu cho việc skincare sẽ gặp rất nhiều khó khăn cho việc lựa chọn sản phẩm phù hợp. Bạn không nên tùy tiện sử dụng bất kì sản phẩm trên da vì rất có thể bạn sẽ dễ bị kích ứng hoặc gây các tổn thương cho da. Vì thế việc chọn các sản phẩm skincare còn phù thuộc vào các yếu tố:\nLựa chọn sản phẩm theo thương hiệu và nguồn gốc rõ ràng: Bạn nên tìm đến các thương hiệu nổi tiếng như Innisfree, Laneige, Shiseido, Kiehls, Neutrogena, Bioderma, Cerave,... Đặc biệt là hãy đặt niềm tin vào những cửa hàng mỹ phẩm chính hãng để đảm bảo chất lượng và an toàn.\nChọn sản phẩm dịu nhẹ: Nếu chưa biết cách phân biệt làn da của mình thì bạn chỉ nên lựa chọn sản phẩm dịu nhẹ, tốt hơn là có chiết xuất từ tự nhiên\nHiểu rõ về thành phần của sản phẩm: Bạn cần hiểu rõ về các thành phần của sản phẩm để tránh gây kích ứng da. Thành phần bạn nên tránh xa nhất chính là fragrances và paraben vì đây là những chất bảo quản không tốt cho da\nHiểu rõ về da: Tuy vào trường hợp của da để bạn chọn sản phẩm phù hợp.Tức là bạn phải hiểu rõ bạn thuộc loại da gì và cần khắc phục những khuyết điểm nào trên gương mặt. Vì mỗi loại da đều có một sản phẩm điều trị riêng nên bạn hãy lưu ý.\nLưu ý để quá trình skincare đạt hiệu quả\n\n\n2. Lưu ý để quá trình skincare đạt hiệu quả\nBạn cần đáp ứng những tiêu chí sau đây:\nThực hiện đầy đủ các bước skincare mỗi ngày\nKhông quên sử dụng kem chống nắng\nKhông thức khuya tiếp xúc với điện thoại, máy vi tính sau khi skincare\nChăm chỉ thực hiện và kiên trì',
      articleAuthor: 'Lý Kiến Hồng',
      articleAuthorImageUrl:
          'https://images.unsplash.com/photo-1617078262771-c2c39ac6867b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
      articleCategory: 'Skincare',
      articleViews: 1234,
      articleImageUrl:
          'https://plus.unsplash.com/premium_photo-1661763460397-abe56ba092d1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      // ignore: prefer_const_literals_to_create_immutables
      articleArrayImageUrl: [
        'https://images.unsplash.com/photo-1542848285-4777eb2a621e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
        'https://images.unsplash.com/photo-1519824145371-296894a0daa9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        'https://images.unsplash.com/photo-1542848284-8afa78a08ccb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
        'https://images.unsplash.com/photo-1542848284-8afa78a08ccb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80'
      ],
    ),
    Article(
      articleId: '2',
      articleTitle: 'Quy trình các bước skincare cơ bản',
      articleSubtitle:
          'Một lưu ý mà chắc hẳn khá quan trọng mà bạn nên biết được để tránh những sai lầm khi thực hiện các bước skincare cơ bản. Có bao giờ bạn thử hỏi chăm sóc da có theo một quá trình không hay chỉ cần đầy đủ các sản phẩm lên mặt là được? Skincare chính là các bước chăm sóc da có trình tự, nguyên tắc cơ bản nhất chính là từ lỏng đến đặc. Đây cũng là mẹo chăm sóc da dầu rất hiệu quả chính vì thế bạn hãy thử qua các bước skincare cho da dầu này nhé!',
      articleBody:
          '1. Các bước skincare buổi tối\nTrình tự: Sữa rửa mặt => Toner => Serum => Kem dưỡng ẩm\n- Tẩy trang\nLàm sạch da chắc chắn là bước bạn không nên bỏ qua được vì nó đóng một vai trò rất rất quan trọng trong các bước chăm sóc da cơ bản. Vì thế bạn nên bắt đầu bằng việc tẩy trang để loại bỏ bụi bẩn, bã nhờn và lớp kem chống nắng sau một ngày dài\nĐặc biệt là đối với những bạn thường xuyên trang điểm mỗi khi ra ngoài thì tuyệt đối không thể bỏ qua bước này. Vì nếu không có nước tẩy trang thì không thể nào làm sạch các lớp trang điểm waterproof. Một số trường hợp các bạn không trang điểm và cũng không ra ngoài thì có cần tẩy trang hay không thì bạn hãy tham khảo thêm bài viết: Giải đáp câu hỏi "Không trang điểm có cần tẩy trang không?"\n- Sữa rửa mặt\n\nNhiều bạn lại rất thắc mắc khi dùng nước tẩy trang làm sạch bụi bẩn rồi mà tại sao phải sử dụng thêm sữa rửa mặt và ngược lại. Thì đó chính là suy nghĩ sai lầm nhất của bạn đấy. Vì bên cạnh việc loại bỏ bụi bẩn bên ngoài thì làn da cần phải làm sạch sâu bên trong lỗ chân lông. Nên việc kết hợp thêm sữa rửa mặt sẽ giúp làn da được chăm sóc kĩ và làm sạch hiệu quả nhất.\nViệc chọn một sản phẩm sữa rửa mặt phù hợp cũng sẽ gây không ít khó khăn vì mỗi loại da đều sẽ có sữa rửa mặt dành riêng và không thể sử dụng bừa đâu nhé! \n- Toner\n\nSẽ thật thiếu sót nếu sau bước làm sạch da mà không sử dụng toner ( nước cân bằng da). Bởi vì sau khi làm sạch da thì ít nhiều làn da của bạn sẽ mất đi độ ẩm khiến da hơi khô căng. Sử dụng toner sẽ giúp bạn cân bằng độ pH cho da và lỗ chân lông được se khít.\n- Đắp mặt nạ\n\nĐắp mặt nạ là bước chăm sóc da không thường xuyên nhưng cũng không thể thiếu vắng. Đắp mặt nạ là lúc làn da được thư giãn và cung cấp nhiều dưỡng chất để phục hồi làn da. Bên cạnh đó còn duy trì độ ẩm cho da để làn da được phát triển tốt và luôn tươi tắn, mịn màng.\n- Serum\nVào buổi tối là thời điểm giúp làn da được hồi phục và tái tạo tốt nhất nên việc sử dụng những loại serum trị thâm mụn nhanh chóng tốt nhất hiện nay sẽ giúp khắc phục tình trạng như nám, tàn nhang, lão hóa cực hiệu quả.\n- Kem dưỡng ẩm\nKem dưỡng ẩm là bước cuối cùng trong chu trình dưỡng da cơ bản. Đây cũng được xem như là bước khóa lại toàn bộ quá trình dưỡng da. Chắc hẳn sẽ rất nhiều bạn thắc mắc kem dưỡng ẩm cho da mặt có chứa thành phần gì mà lại quan trọng vậy? Vì nhờ các thành phần và dưỡng chất có trong kem dưỡng ẩm mà các bước chăm sóc da trước đó thể phát huy được tối đa các công dụng giúp làn da trở nên mịn màng, trắng sáng không tì vết.\n\n\n\n\n2. Các bước skincare buổi sáng\nTrình tự: Sữa rửa mặt => Toner => Serum => Kem dưỡng ẩm => Kem chống nắng\n\nViệc chăm sóc da buổi sáng sẽ giúp làn da của bạn trông tươi tắn hơn để đón chào một ngày mới rạng rỡ. Dù bạn trang điểm hay không trang điểm vào buổi sáng thì một vài bước dưỡng da rất cần thiết để bảo vệ da.\n\nSữa rửa mặt: Buổi sáng bạn chỉ cần sử dụng một lọ sữa rửa mặt dịu nhẹ để loại bỏ dầu nhờn điều tiết trên da sau một giấc ngủ dài.\nToner: Là bước cân bằng độ pH không thể thiếu sau khi dùng sữa rửa mặt\nKem dưỡng ẩm: Vừa có vai trò cung cấp độ ẩm vừa giúp bảo vệ làn da tránh khỏi các tác nhân gây hại từ lớp trang điểm hay từ môi trường bên ngoài\nKem chống nắng: Kem chống nắng được xem như là một vệ sĩ của gương mặt vì nó giúp bảo vệ làn da tối đa chống lại tia UV, tia cực tím của ánh mặt trời.\n\n\n\n\n\n\nTrên đây là những chia sẻ về các bước skincare cơ bản dành cho những bạn mới bắt đầu và là những bước quan trọng không thể thiếu trong chu trình chăm sóc da mỗi ngày. Miên spa cũng đã lưu ý cho bạn để việc chăm sóc da đạt hiệu quả hơn. Hy vọng qua bài viết sẽ giúp các bạn mới bắt đầu skincare biết rõ từng bước theo đúng quy trình để có được làn da khỏe mạnh săn chắc và tươi tắn.',
      articleAuthor: 'Đỗ Huy Hoàng',
      articleAuthorImageUrl:
          'https://images.unsplash.com/photo-1617077644557-64be144aa306?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
      articleCategory: 'Skincare',
      articleViews: 5678,
      articleImageUrl:
          'https://images.unsplash.com/photo-1512290923902-8a9f81dc236c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      createdAt: DateTime.now().subtract(const Duration(hours: 14)),
      // ignore: prefer_const_literals_to_create_immutables
      articleArrayImageUrl: [
        'https://images.unsplash.com/photo-1542848285-4777eb2a621e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
        'https://images.unsplash.com/photo-1519824145371-296894a0daa9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        'https://images.unsplash.com/photo-1542848284-8afa78a08ccb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80'
      ],
    ),
    Article(
      articleId: '3',
      articleTitle: 'Chăm sóc da mặt tại spa có thực sự cần thiết ?',
      articleSubtitle:
          'Ngoài việc chăm sóc da mặt tại nhà thì phụ nữ hiện đại còn có lựa chọn chăm sóc da tại spa. Tuy nhiên, nhiều người vẫn băn khoăn, liệu chăm sóc da tại nhà rồi thì có nên đi spa nữa không?\n\n\nNhững lợi ích của phương pháp này là gì? Tần suất chăm sóc da tại spa bao nhiêu là đủ? Sử dụng máy chăm sóc da nào phù hợp? Cùng tìm hiểu trong bài viết dưới đây nhé!',
      articleBody:
          'Những lợi ích khi chăm sóc da mặt tại spa\n\n\nChăm sóc da mặt tại spa mang lại rất nhiều lợi ích. Lợi ích lớn nhất chính là làm sạch sâu da. Khi được thực hiện đúng cách, chăm sóc da tại spa có thể làm sạch các chất bẩn, bã nhờn trong lỗ chân lông. Tẩy tế bào chết là một phần tất yếu trong quá trình chăm sóc da mặt, giúp da sáng và đều màu hơn. Nếu bạn đang có một làn da xỉn màu, thô ráp, có lẽ đã đến lúc bạn nên ghé thăm spa rồi đấy.\n\nChăm sóc da mặt tại spa mang đến rất nhiều lợi ích. Do đó, bạn nên duy trì điều này như một thói quen để có làn da mịn màng và khoẻ mạnh. Bạn nên duy trì chăm sóc da đều đặn để phòng tránh các vấn đề về da, giữ làn da luôn khỏe mạnh và tươi trẻ.\n\nTuy nhiên, bạn không nên chăm sóc da mặt tại spa quá thường xuyên. Bạn cũng không nên chọn các phương pháp tác động quá mạnh đến da vì có thể làm da bị kích ứng.\n\n\n\nNên chọn spa chăm sóc da với những liệu trình, máy móc kỹ thuật tốt và uy tín?\n\nĐược xem là một loại máy thẩm mỹ đa chức năng chuyên đi serum hay điều trị sâu về da được các trung tâm spa thẩm mỹ sử dụng hỗ trợ điều trị như một quy trình cho các dịch vụ như: chăm sóc da căn bản, nâng cơ, làm trắng... máy chăm sóc da đa năng được sử dụng rộng rãi ở các Beauty Spa, Medical Spa, Day Spa hoặc các cơ sở chăm sóc, điều trị da cơ bản... với những liệu trình như:\n\nChăm sóc da cơ bản: Với người da thường hay bị lão hóa, thâm nám, da bị hư tổn nhiều nên sử dụng máy chăm sóc da đa năng, việc điều trị da trở nên dễ dàng hơn, tính năng ion hóa từ đòng điện 1 chiều truyền qua cơ thể khi được tiếp xúc trực tiếp từ đầu cây lăn điện với dưỡng chất hay serum đi nhanh và đều hơn.\n\n\nLàm trắng da: Với liệu trình làm trắng da mặt cao cấp giúp nuôi dưỡng làn da trắng mịn, khỏe đẹp từ bên trong. Với loại máy chăm sóc đa năng giúp làm sạch da, tẩy sạch vết nám, tàn nhang, đốm nâu… đồng thời ngăn ngừa mụn. Chức năng sóng siêu âm giúp đẩy serum đi sâu vào bên trong, nâng cơ giúp trẻ hóa làn da trắng mịn, sạch nhờn.\n\n\nĐiều trị mụn: Liệu trình trị mụn Nano Skin kết hợp giữa công nghệ và mỹ phẩm cao cấp giúp làm mềm mịn da, tiêu diệt vĩnh viễn mụn trứng cá, mụn đầu trắng, mụn đầu đen, mụn mủ, mụn thịt… giúp nâng cơ mặt giúp trẻ hóa làn da cho làn da trắng mịn không tì vết.\n\n\nNgoài ra, với những liệu trình liên quan đến việc chăm sóc da từ căn bản đến nâng cao...tất cả đều cần đến sự hỗ trợ của máy chăm sóc da đa năng. Khi sử dụng từng chức năng thứ tự trong máy chăm sóc da mặt cho bạn hoặc cho khách hàng sẽ cải thiện đáng kể tình trạng da. Chỉ cần sử dụng 3 lần trong 1 tuần, bạn sẽ cảm thấy sự khác biệt, làn da của bạn đẹp hơn, căng có sức sống hơn, việc điều trị thâm nám trở nên bình thường, da khô cải thiện đáng kể, lỗ chân lông sẽ được thu nhỏ lại,...\n\n\n',
      articleAuthor: 'Ngô Hoàng Giang',
      articleAuthorImageUrl:
          'https://images.unsplash.com/photo-1581711901978-8f66b309fc2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      articleCategory: 'Politics',
      articleViews: 3000,
      articleImageUrl:
          'https://images.unsplash.com/photo-1658786403875-ef4086b78196?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      // ignore: prefer_const_literals_to_create_immutables
      articleArrayImageUrl: [
        'https://images.unsplash.com/photo-1542848285-4777eb2a621e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
        'https://images.unsplash.com/photo-1519824145371-296894a0daa9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        'https://images.unsplash.com/photo-1542848284-8afa78a08ccb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80'
      ],
    ),
    Article(
      articleId: '4',
      articleTitle: 'Những lợi ích từ Spa',
      articleSubtitle:
          'Spa - liệu pháp chăm sóc sắc đẹp, giữ gìn sức khoẻ và thư giãn tinh thần đã có từ thời xa xưa. Tuy nhiên, còn nhiều lợi ích khác mà không phải ai cũng biết.',
      articleBody:
          'Dưới đây là một số tác dụng từ việc đi Spa:\n\nGiảm stress: Cuộc sống nhộn nhịp gây cho bạn nhiều áp lực. Nào là việc ngoài xã hội, việc nội trợ, học hành, chăm sóc con cái... làm bạn tưởng chừng như mình sắp nổ tung ra vì căng thẳng. Hãy dành thời gian thư giãn ở Spa. Đắm mình trong tiếng nhạc du dương, trong làn nước mát với tinh dầu thoang thoảng, bạn sẽ thấy dễ chịu hơn.\n\nTăng sức đề kháng: Khói bụi, ô nhiễm môi trường cùng với thời tiết nóng bức, mệt mỏi do công việc khiến sức đề kháng của cơ thể bạn trở nên yếu đi. Chính vì thế, bạn không đủ sức chống lại những căn bệnh vặt như cảm, nhức đầu, sổ mũi, ho.... Spa sẽ giúp bạn hạn chế bớt những căn bệnh nhỏ nhặt này.\n\n Có lợi cho hệ tim mạch: Hơi thở và nhịp tim có liên quan mật thiết với nhau. Hơi thở đều đặn góp phần làm nhịp tim ổn định. Điều này giúp quá trình trao đổi chất diễn ra một cách thuận lợi. Nhờ vậy, hệ thống tim mạch cũng như vòng tuần hoàn máu của bạn hoạt động hiệu quả hơn.\n\nGiải độc cho cơ thể: Các chất độc nằm sâu bên trong cơ thể bạn ẩn dưới dạng tế bào mỡ cũng dần dần bị loại bỏ dưới tác động của tinh dầu. Ngoài ra, Spa còn có tác dụng cân bằng thể lực cho bạn.\n\nHạn chế các chứng đau khớp, viêm khớp: Quá trình xông hơi tạo điều kiện để các cơ bắp thả lỏng. Từ đó, hơi nước sẽ thâm nhập vào các khớp, mô cứng. Các chứng viêm, đau khớp của bạn vì thế mà dần dần được cải thiện đáng kể.\n\n Giảm nguy cơ ung thư: Thân nhiệt của bạn luôn trong trạng thái cao khi tắm Spa kéo theo sự cải tiến của hệ miễn nhiễm. Chính vì điều này có tác dụng thúc đẩy quá trình đào thải những hoá chất gây ung thư như: natri (sodium), alcohol, nicotine...\n\nGiấc ngủ ngon: Theo nghiên cứu, một giấc ngủ ngon và sâu có được do sự kết hợp hài hoà giữa nhiều yếu tố. Trong đó, sức khoẻ và tinh thần thoải mái là yếu tố quyết định. Hãy chăm sóc cho giấc ngủ của chính mình.\n\nBí quyết sống lâu và khoẻ: Một tinh thần sảng khoái và cơ thể khoẻ mạnh là bí quyết kéo tuổi thọ của bạn dài thêm 10 năm nữa đấy. Đừng bỏ qua cơ hội để tận hưởng cuộc sống bạn nhé.\n\n',
      articleAuthor: 'Đỗ Trí Thịnh',
      articleAuthorImageUrl:
          'https://images.unsplash.com/photo-1544973810-7ecf787e9608?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=426&q=80',
      articleCategory: 'Politics',
      articleViews: 2000,
      articleImageUrl:
          'https://images.unsplash.com/photo-1531299204812-e6d44d9a185c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      createdAt: DateTime.now().subtract(const Duration(hours: 17)),
      // ignore: prefer_const_literals_to_create_immutables
      articleArrayImageUrl: [
        'https://images.unsplash.com/photo-1542848285-4777eb2a621e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
        'https://images.unsplash.com/photo-1519824145371-296894a0daa9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        'https://images.unsplash.com/photo-1542848284-8afa78a08ccb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80'
      ],
    ),
    Article(
      articleId: '5',
      articleTitle:
          'Cách Nhận Biết Spa Uy Tín Có Thể Yên Tâm Lựa Chọn Để Làm Đẹp',
      articleSubtitle:
          'Trên thị trường có hằng hà sa số các đơn vị spa làm đẹp, nhất là những thành phố lớn như Hà Nội, TP Hồ Chí Minh, Cần Thơ, Hải Phòng… Vì vậy, làm thế nào để có thể nhận biết một spa uy tín khiến bản thân có thể yên tâm chăm sóc, tút tát nhan sắc luôn là điều nhận được sự quan tâm của nhiều chị em.',
      articleBody:
          'Spa uy tín thường được nhiều người biết đến\n\nĐây là một trong những dấu hiệu hàng đầu minh chứng về độ uy tín, đáng tin cậy của cơ sở kinh doanh spa. Thông thường, các spa có nhiều người biết đến sẽ đông khách và mang lại các dịch vụ tốt. \n\nHơn nữa, điều này còn thể hiện độ”chịu chi”của cơ sở kinh doanh spa đó cho việc quảng cáo, marketing, xây dựng bộ nhận diện thương hiệu và phủ rộng khắp các kênh từ truyền thông từ truyền thống đến online…\n\nSpa uy tín sẽ được khách hàng phản hồi tốt về chất lượng dịch vụ\n\nĐể biết được cơ sở spa đó có tốt hay không bạn hãy hỏi thăm bạn bè, người thân, đồng nghiệp, người quen của mình đã có ai đến làm dịch vụ chưa và xem phản hồi của họ như thế nào. Ngoài ra, cũng có thể lên các hội nhóm trên Facebook, mạng xã hội để xem review của mọi người.\n\nPhản hồi chân thực từ những người đã từng thực hiện dịch vụ tại cơ sở kinh doanh spa đó, sẽ giúp bạn có được cái nhìn khách quan hơn. Từ đó  dễ dàng biết được đâu là địa chỉ uy tín để yên tâm “chọn mặt gửi vàng”.\n\nSpa uy tín có giá cả rõ ràng, minh bạch\n\nCác spa uy tín thường có giá cả rất hợp lý, giá cả luôn đi đôi với chất lượng. Đồng thời, tiền bạc rất rõ ràng, minh bạch, hoàn toàn không có tình trạng phát sinh chi phí trong quá trình điều trị hay vẽ bệnh, đôn giá…\n\nNgoài ra, các cơ sở kinh doanh làm ăn chân chính cũng đều mang lại sự thoải mái cho khách hàng. Không có tình trạng ép khách hàng phải mua dịch vụ, chèo kéo và luôn thông báo rõ cho khách hàng trước khi làm. \n\nSpa uy tín sẽ sử dụng mỹ phẩm chất lượng\n\nMỹ phẩm là một phần đóng vai trò rất quan trọng trong việc quyết định hiệu quả của dịch vụ. Thực tế, các spa uy tín luôn sử dụng những loại mỹ phẩm, từ sữa rửa mặt, kem tẩy tế bào chết, mặt nạ, đến serum, tinh chất đặc trị… đều là hàng có nguồn gốc xuất xứ rõ ràng, do thương hiệu lớn sản xuất. Khi sử dụng vừa giúp cải thiện những vấn đề về da nhanh chóng, vừa đảm bảo an toàn. \n\nNgược lại, những chủ mở spa làm ăn bất chính, cơ sở nhỏ lẻ, thiếu chuyên nghiệp hay dùng mỹ phẩm kém chất lượng, không rõ nguồn gốc, kem trộn, hàng trôi nổi… để tiết kiệm chi phí. Đặc biệt, hầu hết chúng đều chứa hoá chất độc hại, rất nguy hiểm cho khách hàng.\n\nSpa uy tín sẽ trang bị máy móc hiện đại\n\nNgoài đáp ứng các tiêu chí trên, cơ sở kinh doanh spa uy tín còn phải trang bị hệ thống máy móc hiện đại và có công nghệ cao. Bạn nên chọn nơi setup spa với sản phẩm công nghệ cao do IDM Việt Nam cung cấp như: \n\nMáy giảm béo LS650 A5, Slim Sure, Ice Shaping IV Pro, Med 360, V8-Pmp, Vs3, Rf 5.6, Slimor….; Máy triệt lông RG 568, Diode Laser 808 – H6, Skinlight +, Diode Laser 1200w, Diode Laser Med 808,…; Máy nâng cơ Hifu Vmax, Hifu EClip +, Hifu Eclip, Hifu Ulche – Bison, Hifu FU4.5-10S, nâng cơ RF Baron đỏ, RF Baron trắng, RF375, Golden Fingers R79; Máy điều trị sắc tố da Ruby Star, máy trị nám Pico Silver, máy trị nám Lucid Q-PTP, máy trị sẹo More-Xel Scanning…\n\n\nĐây đều là những sản phẩm tốt, hàng chính hãng, được nhập khẩu trực tiếp từ các đơn vị uy tín như BISON, BECO… và có chứng từ CO CQ, hóa đơn đầy đủ. Khi sử dụng sẽ mang lại hiệu quả rất tốt, hơn nữa lại rất an toàn.\n\nHy vọng rằng với một vài gợi ý trên đây sẽ bạn nhận biết spa uy tín có thể yên tâm lựa chọn để làm đẹp. Chúc bạn thành công!\n\n',
      articleAuthor: 'Dương Tấn Sỹ',
      articleAuthorImageUrl:
          'https://images.unsplash.com/photo-1579734204067-c337a611376c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      articleCategory: 'Politics',
      articleViews: 406,
      articleImageUrl:
          'https://images.unsplash.com/photo-1519415510236-718bdfcd89c8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      createdAt: DateTime.now().subtract(const Duration(hours: 222)),
      // ignore: prefer_const_literals_to_create_immutables
      articleArrayImageUrl: [
        'https://images.unsplash.com/photo-1542848285-4777eb2a621e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
        'https://images.unsplash.com/photo-1519824145371-296894a0daa9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        'https://images.unsplash.com/photo-1542848284-8afa78a08ccb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80'
      ],
    ),
    Article(
      articleId: '6',
      articleTitle: 'Thông tin cơ bản về skincare',
      articleSubtitle:
          'Có lẽ ngày nay việc chăm sóc da mỗi ngày dường như đã trở thành một thói quen của phái đẹp. Việc skincare mỗi ngày sẽ giúp làn da mịn màng, đầy sức sống hơn, giảm thiểu các vấn đề về da do các yếu tố bên ngoài. Vậy các bước skincare như thế nào để việc chăm sóc da đạt hiệu quả cao? Hãy cùng Miên Spa tìm hiểu về cách lựa chọn sản phẩm phù hợp cho da và các bước skincare cơ bản nhé!',
      articleBody:
          'Lựa chọn sản phẩm phù hợp cho da\n\n\n1. Lưu ý khi lựa chọn sản phẩm\nĐối với người mới bắt đầu cho việc skincare sẽ gặp rất nhiều khó khăn cho việc lựa chọn sản phẩm phù hợp. Bạn không nên tùy tiện sử dụng bất kì sản phẩm trên da vì rất có thể bạn sẽ dễ bị kích ứng hoặc gây các tổn thương cho da. Vì thế việc chọn các sản phẩm skincare còn phù thuộc vào các yếu tố:\nLựa chọn sản phẩm theo thương hiệu và nguồn gốc rõ ràng: Bạn nên tìm đến các thương hiệu nổi tiếng như Innisfree, Laneige, Shiseido, Kiehls, Neutrogena, Bioderma, Cerave,... Đặc biệt là hãy đặt niềm tin vào những cửa hàng mỹ phẩm chính hãng để đảm bảo chất lượng và an toàn.\nChọn sản phẩm dịu nhẹ: Nếu chưa biết cách phân biệt làn da của mình thì bạn chỉ nên lựa chọn sản phẩm dịu nhẹ, tốt hơn là có chiết xuất từ tự nhiên\nHiểu rõ về thành phần của sản phẩm: Bạn cần hiểu rõ về các thành phần của sản phẩm để tránh gây kích ứng da. Thành phần bạn nên tránh xa nhất chính là fragrances và paraben vì đây là những chất bảo quản không tốt cho da\nHiểu rõ về da: Tuy vào trường hợp của da để bạn chọn sản phẩm phù hợp.Tức là bạn phải hiểu rõ bạn thuộc loại da gì và cần khắc phục những khuyết điểm nào trên gương mặt. Vì mỗi loại da đều có một sản phẩm điều trị riêng nên bạn hãy lưu ý.\nLưu ý để quá trình skincare đạt hiệu quả\n\n\n2. Lưu ý để quá trình skincare đạt hiệu quả\nBạn cần đáp ứng những tiêu chí sau đây:\nThực hiện đầy đủ các bước skincare mỗi ngày\nKhông quên sử dụng kem chống nắng\nKhông thức khuya tiếp xúc với điện thoại, máy vi tính sau khi skincare\nChăm chỉ thực hiện và kiên trì',
      articleAuthor: 'Lý Kiến Hồng',
      articleAuthorImageUrl:
          'https://images.unsplash.com/photo-1617078262771-c2c39ac6867b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
      articleCategory: 'Skincare',
      articleViews: 1234,
      articleImageUrl:
          'https://plus.unsplash.com/premium_photo-1661763460397-abe56ba092d1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      // ignore: prefer_const_literals_to_create_immutables
      articleArrayImageUrl: [
        'https://images.unsplash.com/photo-1542848285-4777eb2a621e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
        'https://images.unsplash.com/photo-1519824145371-296894a0daa9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        'https://images.unsplash.com/photo-1542848284-8afa78a08ccb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
        'https://images.unsplash.com/photo-1542848284-8afa78a08ccb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80'
      ],
    ),
    Article(
      articleId: '7',
      articleTitle: 'Quy trình các bước skincare cơ bản',
      articleSubtitle:
          'Một lưu ý mà chắc hẳn khá quan trọng mà bạn nên biết được để tránh những sai lầm khi thực hiện các bước skincare cơ bản. Có bao giờ bạn thử hỏi chăm sóc da có theo một quá trình không hay chỉ cần đầy đủ các sản phẩm lên mặt là được? Skincare chính là các bước chăm sóc da có trình tự, nguyên tắc cơ bản nhất chính là từ lỏng đến đặc. Đây cũng là mẹo chăm sóc da dầu rất hiệu quả chính vì thế bạn hãy thử qua các bước skincare cho da dầu này nhé!',
      articleBody:
          '1. Các bước skincare buổi tối\nTrình tự: Sữa rửa mặt => Toner => Serum => Kem dưỡng ẩm\n- Tẩy trang\nLàm sạch da chắc chắn là bước bạn không nên bỏ qua được vì nó đóng một vai trò rất rất quan trọng trong các bước chăm sóc da cơ bản. Vì thế bạn nên bắt đầu bằng việc tẩy trang để loại bỏ bụi bẩn, bã nhờn và lớp kem chống nắng sau một ngày dài\nĐặc biệt là đối với những bạn thường xuyên trang điểm mỗi khi ra ngoài thì tuyệt đối không thể bỏ qua bước này. Vì nếu không có nước tẩy trang thì không thể nào làm sạch các lớp trang điểm waterproof. Một số trường hợp các bạn không trang điểm và cũng không ra ngoài thì có cần tẩy trang hay không thì bạn hãy tham khảo thêm bài viết: Giải đáp câu hỏi "Không trang điểm có cần tẩy trang không?"\n- Sữa rửa mặt\n\nNhiều bạn lại rất thắc mắc khi dùng nước tẩy trang làm sạch bụi bẩn rồi mà tại sao phải sử dụng thêm sữa rửa mặt và ngược lại. Thì đó chính là suy nghĩ sai lầm nhất của bạn đấy. Vì bên cạnh việc loại bỏ bụi bẩn bên ngoài thì làn da cần phải làm sạch sâu bên trong lỗ chân lông. Nên việc kết hợp thêm sữa rửa mặt sẽ giúp làn da được chăm sóc kĩ và làm sạch hiệu quả nhất.\nViệc chọn một sản phẩm sữa rửa mặt phù hợp cũng sẽ gây không ít khó khăn vì mỗi loại da đều sẽ có sữa rửa mặt dành riêng và không thể sử dụng bừa đâu nhé! \n- Toner\n\nSẽ thật thiếu sót nếu sau bước làm sạch da mà không sử dụng toner ( nước cân bằng da). Bởi vì sau khi làm sạch da thì ít nhiều làn da của bạn sẽ mất đi độ ẩm khiến da hơi khô căng. Sử dụng toner sẽ giúp bạn cân bằng độ pH cho da và lỗ chân lông được se khít.\n- Đắp mặt nạ\n\nĐắp mặt nạ là bước chăm sóc da không thường xuyên nhưng cũng không thể thiếu vắng. Đắp mặt nạ là lúc làn da được thư giãn và cung cấp nhiều dưỡng chất để phục hồi làn da. Bên cạnh đó còn duy trì độ ẩm cho da để làn da được phát triển tốt và luôn tươi tắn, mịn màng.\n- Serum\nVào buổi tối là thời điểm giúp làn da được hồi phục và tái tạo tốt nhất nên việc sử dụng những loại serum trị thâm mụn nhanh chóng tốt nhất hiện nay sẽ giúp khắc phục tình trạng như nám, tàn nhang, lão hóa cực hiệu quả.\n- Kem dưỡng ẩm\nKem dưỡng ẩm là bước cuối cùng trong chu trình dưỡng da cơ bản. Đây cũng được xem như là bước khóa lại toàn bộ quá trình dưỡng da. Chắc hẳn sẽ rất nhiều bạn thắc mắc kem dưỡng ẩm cho da mặt có chứa thành phần gì mà lại quan trọng vậy? Vì nhờ các thành phần và dưỡng chất có trong kem dưỡng ẩm mà các bước chăm sóc da trước đó thể phát huy được tối đa các công dụng giúp làn da trở nên mịn màng, trắng sáng không tì vết.\n\n\n\n\n2. Các bước skincare buổi sáng\nTrình tự: Sữa rửa mặt => Toner => Serum => Kem dưỡng ẩm => Kem chống nắng\n\nViệc chăm sóc da buổi sáng sẽ giúp làn da của bạn trông tươi tắn hơn để đón chào một ngày mới rạng rỡ. Dù bạn trang điểm hay không trang điểm vào buổi sáng thì một vài bước dưỡng da rất cần thiết để bảo vệ da.\n\nSữa rửa mặt: Buổi sáng bạn chỉ cần sử dụng một lọ sữa rửa mặt dịu nhẹ để loại bỏ dầu nhờn điều tiết trên da sau một giấc ngủ dài.\nToner: Là bước cân bằng độ pH không thể thiếu sau khi dùng sữa rửa mặt\nKem dưỡng ẩm: Vừa có vai trò cung cấp độ ẩm vừa giúp bảo vệ làn da tránh khỏi các tác nhân gây hại từ lớp trang điểm hay từ môi trường bên ngoài\nKem chống nắng: Kem chống nắng được xem như là một vệ sĩ của gương mặt vì nó giúp bảo vệ làn da tối đa chống lại tia UV, tia cực tím của ánh mặt trời.\n\n\n\n\n\n\nTrên đây là những chia sẻ về các bước skincare cơ bản dành cho những bạn mới bắt đầu và là những bước quan trọng không thể thiếu trong chu trình chăm sóc da mỗi ngày. Miên spa cũng đã lưu ý cho bạn để việc chăm sóc da đạt hiệu quả hơn. Hy vọng qua bài viết sẽ giúp các bạn mới bắt đầu skincare biết rõ từng bước theo đúng quy trình để có được làn da khỏe mạnh săn chắc và tươi tắn.',
      articleAuthor: 'Đỗ Huy Hoàng',
      articleAuthorImageUrl:
          'https://images.unsplash.com/photo-1617077644557-64be144aa306?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
      articleCategory: 'Skincare',
      articleViews: 5678,
      articleImageUrl:
          'https://images.unsplash.com/photo-1512290923902-8a9f81dc236c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      createdAt: DateTime.now().subtract(const Duration(hours: 14)),
      // ignore: prefer_const_literals_to_create_immutables
      articleArrayImageUrl: [
        'https://images.unsplash.com/photo-1542848285-4777eb2a621e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
        'https://images.unsplash.com/photo-1519824145371-296894a0daa9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        'https://images.unsplash.com/photo-1542848284-8afa78a08ccb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80'
      ],
    ),
    Article(
      articleId: '8',
      articleTitle: 'Chăm sóc da mặt tại spa có thực sự cần thiết ?',
      articleSubtitle:
          'Ngoài việc chăm sóc da mặt tại nhà thì phụ nữ hiện đại còn có lựa chọn chăm sóc da tại spa. Tuy nhiên, nhiều người vẫn băn khoăn, liệu chăm sóc da tại nhà rồi thì có nên đi spa nữa không?\n\n\nNhững lợi ích của phương pháp này là gì? Tần suất chăm sóc da tại spa bao nhiêu là đủ? Sử dụng máy chăm sóc da nào phù hợp? Cùng tìm hiểu trong bài viết dưới đây nhé!',
      articleBody:
          'Những lợi ích khi chăm sóc da mặt tại spa\n\n\nChăm sóc da mặt tại spa mang lại rất nhiều lợi ích. Lợi ích lớn nhất chính là làm sạch sâu da. Khi được thực hiện đúng cách, chăm sóc da tại spa có thể làm sạch các chất bẩn, bã nhờn trong lỗ chân lông. Tẩy tế bào chết là một phần tất yếu trong quá trình chăm sóc da mặt, giúp da sáng và đều màu hơn. Nếu bạn đang có một làn da xỉn màu, thô ráp, có lẽ đã đến lúc bạn nên ghé thăm spa rồi đấy.\n\nChăm sóc da mặt tại spa mang đến rất nhiều lợi ích. Do đó, bạn nên duy trì điều này như một thói quen để có làn da mịn màng và khoẻ mạnh. Bạn nên duy trì chăm sóc da đều đặn để phòng tránh các vấn đề về da, giữ làn da luôn khỏe mạnh và tươi trẻ.\n\nTuy nhiên, bạn không nên chăm sóc da mặt tại spa quá thường xuyên. Bạn cũng không nên chọn các phương pháp tác động quá mạnh đến da vì có thể làm da bị kích ứng.\n\n\n\nNên chọn spa chăm sóc da với những liệu trình, máy móc kỹ thuật tốt và uy tín?\n\nĐược xem là một loại máy thẩm mỹ đa chức năng chuyên đi serum hay điều trị sâu về da được các trung tâm spa thẩm mỹ sử dụng hỗ trợ điều trị như một quy trình cho các dịch vụ như: chăm sóc da căn bản, nâng cơ, làm trắng... máy chăm sóc da đa năng được sử dụng rộng rãi ở các Beauty Spa, Medical Spa, Day Spa hoặc các cơ sở chăm sóc, điều trị da cơ bản... với những liệu trình như:\n\nChăm sóc da cơ bản: Với người da thường hay bị lão hóa, thâm nám, da bị hư tổn nhiều nên sử dụng máy chăm sóc da đa năng, việc điều trị da trở nên dễ dàng hơn, tính năng ion hóa từ đòng điện 1 chiều truyền qua cơ thể khi được tiếp xúc trực tiếp từ đầu cây lăn điện với dưỡng chất hay serum đi nhanh và đều hơn.\n\n\nLàm trắng da: Với liệu trình làm trắng da mặt cao cấp giúp nuôi dưỡng làn da trắng mịn, khỏe đẹp từ bên trong. Với loại máy chăm sóc đa năng giúp làm sạch da, tẩy sạch vết nám, tàn nhang, đốm nâu… đồng thời ngăn ngừa mụn. Chức năng sóng siêu âm giúp đẩy serum đi sâu vào bên trong, nâng cơ giúp trẻ hóa làn da trắng mịn, sạch nhờn.\n\n\nĐiều trị mụn: Liệu trình trị mụn Nano Skin kết hợp giữa công nghệ và mỹ phẩm cao cấp giúp làm mềm mịn da, tiêu diệt vĩnh viễn mụn trứng cá, mụn đầu trắng, mụn đầu đen, mụn mủ, mụn thịt… giúp nâng cơ mặt giúp trẻ hóa làn da cho làn da trắng mịn không tì vết.\n\n\nNgoài ra, với những liệu trình liên quan đến việc chăm sóc da từ căn bản đến nâng cao...tất cả đều cần đến sự hỗ trợ của máy chăm sóc da đa năng. Khi sử dụng từng chức năng thứ tự trong máy chăm sóc da mặt cho bạn hoặc cho khách hàng sẽ cải thiện đáng kể tình trạng da. Chỉ cần sử dụng 3 lần trong 1 tuần, bạn sẽ cảm thấy sự khác biệt, làn da của bạn đẹp hơn, căng có sức sống hơn, việc điều trị thâm nám trở nên bình thường, da khô cải thiện đáng kể, lỗ chân lông sẽ được thu nhỏ lại,...\n\n\n',
      articleAuthor: 'Ngô Hoàng Giang',
      articleAuthorImageUrl:
          'https://images.unsplash.com/photo-1581711901978-8f66b309fc2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      articleCategory: 'Politics',
      articleViews: 3000,
      articleImageUrl:
          'https://images.unsplash.com/photo-1658786403875-ef4086b78196?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      // ignore: prefer_const_literals_to_create_immutables
      articleArrayImageUrl: [
        'https://images.unsplash.com/photo-1542848285-4777eb2a621e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
        'https://images.unsplash.com/photo-1519824145371-296894a0daa9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        'https://images.unsplash.com/photo-1542848284-8afa78a08ccb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80'
      ],
    ),
    Article(
      articleId: '9',
      articleTitle: 'Những lợi ích từ Spa',
      articleSubtitle:
          'Spa - liệu pháp chăm sóc sắc đẹp, giữ gìn sức khoẻ và thư giãn tinh thần đã có từ thời xa xưa. Tuy nhiên, còn nhiều lợi ích khác mà không phải ai cũng biết.',
      articleBody:
          'Dưới đây là một số tác dụng từ việc đi Spa:\n\nGiảm stress: Cuộc sống nhộn nhịp gây cho bạn nhiều áp lực. Nào là việc ngoài xã hội, việc nội trợ, học hành, chăm sóc con cái... làm bạn tưởng chừng như mình sắp nổ tung ra vì căng thẳng. Hãy dành thời gian thư giãn ở Spa. Đắm mình trong tiếng nhạc du dương, trong làn nước mát với tinh dầu thoang thoảng, bạn sẽ thấy dễ chịu hơn.\n\nTăng sức đề kháng: Khói bụi, ô nhiễm môi trường cùng với thời tiết nóng bức, mệt mỏi do công việc khiến sức đề kháng của cơ thể bạn trở nên yếu đi. Chính vì thế, bạn không đủ sức chống lại những căn bệnh vặt như cảm, nhức đầu, sổ mũi, ho.... Spa sẽ giúp bạn hạn chế bớt những căn bệnh nhỏ nhặt này.\n\n Có lợi cho hệ tim mạch: Hơi thở và nhịp tim có liên quan mật thiết với nhau. Hơi thở đều đặn góp phần làm nhịp tim ổn định. Điều này giúp quá trình trao đổi chất diễn ra một cách thuận lợi. Nhờ vậy, hệ thống tim mạch cũng như vòng tuần hoàn máu của bạn hoạt động hiệu quả hơn.\n\nGiải độc cho cơ thể: Các chất độc nằm sâu bên trong cơ thể bạn ẩn dưới dạng tế bào mỡ cũng dần dần bị loại bỏ dưới tác động của tinh dầu. Ngoài ra, Spa còn có tác dụng cân bằng thể lực cho bạn.\n\nHạn chế các chứng đau khớp, viêm khớp: Quá trình xông hơi tạo điều kiện để các cơ bắp thả lỏng. Từ đó, hơi nước sẽ thâm nhập vào các khớp, mô cứng. Các chứng viêm, đau khớp của bạn vì thế mà dần dần được cải thiện đáng kể.\n\n Giảm nguy cơ ung thư: Thân nhiệt của bạn luôn trong trạng thái cao khi tắm Spa kéo theo sự cải tiến của hệ miễn nhiễm. Chính vì điều này có tác dụng thúc đẩy quá trình đào thải những hoá chất gây ung thư như: natri (sodium), alcohol, nicotine...\n\nGiấc ngủ ngon: Theo nghiên cứu, một giấc ngủ ngon và sâu có được do sự kết hợp hài hoà giữa nhiều yếu tố. Trong đó, sức khoẻ và tinh thần thoải mái là yếu tố quyết định. Hãy chăm sóc cho giấc ngủ của chính mình.\n\nBí quyết sống lâu và khoẻ: Một tinh thần sảng khoái và cơ thể khoẻ mạnh là bí quyết kéo tuổi thọ của bạn dài thêm 10 năm nữa đấy. Đừng bỏ qua cơ hội để tận hưởng cuộc sống bạn nhé.\n\n',
      articleAuthor: 'Đỗ Trí Thịnh',
      articleAuthorImageUrl:
          'https://images.unsplash.com/photo-1544973810-7ecf787e9608?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=426&q=80',
      articleCategory: 'Politics',
      articleViews: 2000,
      articleImageUrl:
          'https://images.unsplash.com/photo-1531299204812-e6d44d9a185c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      createdAt: DateTime.now().subtract(const Duration(hours: 17)),
      // ignore: prefer_const_literals_to_create_immutables
      articleArrayImageUrl: [
        'https://images.unsplash.com/photo-1542848285-4777eb2a621e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
        'https://images.unsplash.com/photo-1519824145371-296894a0daa9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        'https://images.unsplash.com/photo-1542848284-8afa78a08ccb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80'
      ],
    ),
    Article(
      articleId: '10',
      articleTitle:
          'Cách Nhận Biết Spa Uy Tín Có Thể Yên Tâm Lựa Chọn Để Làm Đẹp',
      articleSubtitle:
          'Trên thị trường có hằng hà sa số các đơn vị spa làm đẹp, nhất là những thành phố lớn như Hà Nội, TP Hồ Chí Minh, Cần Thơ, Hải Phòng… Vì vậy, làm thế nào để có thể nhận biết một spa uy tín khiến bản thân có thể yên tâm chăm sóc, tút tát nhan sắc luôn là điều nhận được sự quan tâm của nhiều chị em.',
      articleBody:
          'Spa uy tín thường được nhiều người biết đến\n\nĐây là một trong những dấu hiệu hàng đầu minh chứng về độ uy tín, đáng tin cậy của cơ sở kinh doanh spa. Thông thường, các spa có nhiều người biết đến sẽ đông khách và mang lại các dịch vụ tốt. \n\nHơn nữa, điều này còn thể hiện độ”chịu chi”của cơ sở kinh doanh spa đó cho việc quảng cáo, marketing, xây dựng bộ nhận diện thương hiệu và phủ rộng khắp các kênh từ truyền thông từ truyền thống đến online…\n\nSpa uy tín sẽ được khách hàng phản hồi tốt về chất lượng dịch vụ\n\nĐể biết được cơ sở spa đó có tốt hay không bạn hãy hỏi thăm bạn bè, người thân, đồng nghiệp, người quen của mình đã có ai đến làm dịch vụ chưa và xem phản hồi của họ như thế nào. Ngoài ra, cũng có thể lên các hội nhóm trên Facebook, mạng xã hội để xem review của mọi người.\n\nPhản hồi chân thực từ những người đã từng thực hiện dịch vụ tại cơ sở kinh doanh spa đó, sẽ giúp bạn có được cái nhìn khách quan hơn. Từ đó  dễ dàng biết được đâu là địa chỉ uy tín để yên tâm “chọn mặt gửi vàng”.\n\nSpa uy tín có giá cả rõ ràng, minh bạch\n\nCác spa uy tín thường có giá cả rất hợp lý, giá cả luôn đi đôi với chất lượng. Đồng thời, tiền bạc rất rõ ràng, minh bạch, hoàn toàn không có tình trạng phát sinh chi phí trong quá trình điều trị hay vẽ bệnh, đôn giá…\n\nNgoài ra, các cơ sở kinh doanh làm ăn chân chính cũng đều mang lại sự thoải mái cho khách hàng. Không có tình trạng ép khách hàng phải mua dịch vụ, chèo kéo và luôn thông báo rõ cho khách hàng trước khi làm. \n\nSpa uy tín sẽ sử dụng mỹ phẩm chất lượng\n\nMỹ phẩm là một phần đóng vai trò rất quan trọng trong việc quyết định hiệu quả của dịch vụ. Thực tế, các spa uy tín luôn sử dụng những loại mỹ phẩm, từ sữa rửa mặt, kem tẩy tế bào chết, mặt nạ, đến serum, tinh chất đặc trị… đều là hàng có nguồn gốc xuất xứ rõ ràng, do thương hiệu lớn sản xuất. Khi sử dụng vừa giúp cải thiện những vấn đề về da nhanh chóng, vừa đảm bảo an toàn. \n\nNgược lại, những chủ mở spa làm ăn bất chính, cơ sở nhỏ lẻ, thiếu chuyên nghiệp hay dùng mỹ phẩm kém chất lượng, không rõ nguồn gốc, kem trộn, hàng trôi nổi… để tiết kiệm chi phí. Đặc biệt, hầu hết chúng đều chứa hoá chất độc hại, rất nguy hiểm cho khách hàng.\n\nSpa uy tín sẽ trang bị máy móc hiện đại\n\nNgoài đáp ứng các tiêu chí trên, cơ sở kinh doanh spa uy tín còn phải trang bị hệ thống máy móc hiện đại và có công nghệ cao. Bạn nên chọn nơi setup spa với sản phẩm công nghệ cao do IDM Việt Nam cung cấp như: \n\nMáy giảm béo LS650 A5, Slim Sure, Ice Shaping IV Pro, Med 360, V8-Pmp, Vs3, Rf 5.6, Slimor….; Máy triệt lông RG 568, Diode Laser 808 – H6, Skinlight +, Diode Laser 1200w, Diode Laser Med 808,…; Máy nâng cơ Hifu Vmax, Hifu EClip +, Hifu Eclip, Hifu Ulche – Bison, Hifu FU4.5-10S, nâng cơ RF Baron đỏ, RF Baron trắng, RF375, Golden Fingers R79; Máy điều trị sắc tố da Ruby Star, máy trị nám Pico Silver, máy trị nám Lucid Q-PTP, máy trị sẹo More-Xel Scanning…\n\n\nĐây đều là những sản phẩm tốt, hàng chính hãng, được nhập khẩu trực tiếp từ các đơn vị uy tín như BISON, BECO… và có chứng từ CO CQ, hóa đơn đầy đủ. Khi sử dụng sẽ mang lại hiệu quả rất tốt, hơn nữa lại rất an toàn.\n\nHy vọng rằng với một vài gợi ý trên đây sẽ bạn nhận biết spa uy tín có thể yên tâm lựa chọn để làm đẹp. Chúc bạn thành công!\n\n',
      articleAuthor: 'Dương Tấn Sỹ',
      articleAuthorImageUrl:
          'https://images.unsplash.com/photo-1579734204067-c337a611376c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      articleCategory: 'Politics',
      articleViews: 406,
      articleImageUrl:
          'https://images.unsplash.com/photo-1519415510236-718bdfcd89c8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      createdAt: DateTime.now().subtract(const Duration(hours: 222)),
      // ignore: prefer_const_literals_to_create_immutables
      articleArrayImageUrl: [
        'https://images.unsplash.com/photo-1542848285-4777eb2a621e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
        'https://images.unsplash.com/photo-1519824145371-296894a0daa9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        'https://images.unsplash.com/photo-1542848284-8afa78a08ccb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80'
      ],
    ),
  ];

  @override
  List<Object?> get props => [
        articleId,
        articleTitle,
        articleSubtitle,
        articleBody,
        articleAuthor,
        articleAuthorImageUrl,
        articleCategory,
        articleImageUrl,
        articleArrayImageUrl,
        articleViews,
        createdAt
      ];
}
