//
//  VCNewsList.swift
//  RxNews
//
//  Created by minho on 2021/05/27.
//

import RxCocoa
import RxSwift
import UIKit

class VCNewsList: UITableViewController {
    let disposeBag: DisposeBag = DisposeBag()
    private var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        fetchNews()
    }

    func fetchNews() {
        let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2021-04-26&sortBy=publishedAt&apiKey=")!

        Observable.just(url)
            .flatMap({ url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }).map({ data -> [Article]? in
                return try? JSONDecoder().decode(ArticleList.self, from: data).articles
            }).subscribe(onNext: { [weak self] articles in
                if let articles = articles {
                    self?.articles = articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ArticleTableViewCell.self)", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell does not exist")
        }
        cell.titleLabel.text = articles[indexPath.row].title
        cell.descriptionLabel.text = articles[indexPath.row].description
        return cell
    }
}
