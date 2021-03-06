//
//  SortTableViewCtrlProtocol.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/6/15.
//  Copyright © 2015 Coruja Virtual. All rights reserved.
//

/**
Communication protocol between ArticleListCtrl and Api
*/
protocol ApiProc
{
    func didSaveArticles(articles: [Article])
    func articlesSorted(articles: [Article])
}