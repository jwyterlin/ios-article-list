//
//  ArticleTableViewProtocol.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/5/15.
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.
//

/**
Communication protocol between ArticleTableView and ArticleListCtrl
*/
protocol ArticleTableViewProc
{
    func articleSelected(article: Article)
    func sharingOptionsSelected()
}