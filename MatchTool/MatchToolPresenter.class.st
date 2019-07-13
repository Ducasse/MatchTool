"
This is a tool that allows one to test and explore RB matching expressions

MatchToolPresenter new openWithSpec 

The main window consist of 3 columns. The first column consists of two code areas. The top one should be used to enter a match code also known as pattern code, while the bottom one should be used for entering plain Smalltalk code as a test sample. Both text areas can be switched into a ""method mode"" where they will parse the entered text as if it were a method, otherwise they expect the entered code to be an expression. The second column contains the result of matching, a help button and the main execute button (with a cmd(ctrl)+enter shortcut) on top of it. After the button is pressed, both match code and test code are accepted and if there are no errors the matching is performed. MatchTool searches for the match pattern in all the test samples and lists the detected matches in the result list. Clicking on the items from the result list highlights the matched interval in the test sample code area and shows the match map of the pattern code in the third column.

Match map probably needs more explanation. Imagine you have a pattern

`item printOn: `@expr
While it will match a test sample

url printOn: FileStream stdout
the match map list will tell you that ``itemwas mapped tourl` while ` `@expr` was mapped to `FileStream stdout`.


"
Class {
	#name : #MatchToolPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'matchExpression',
		'testExpression',
		'resultList',
		'matchMap',
		'executeButton',
		'helpButton'
	],
	#category : #'MatchTool-CorePresenter'
}

{ #category : #specs }
MatchToolPresenter class >> defaultSpec [

	 "^ SpLayout composed
		newColumn: [ :col | col
			add: #matchExpression;
			add: #testExpression. ]
		origin: 0 @ 0 corner: 0.46 @ 1;
		
		newColumn: [ :col | col
			newRow: [ :buttonRow | buttonRow
				add: #executeButton;
				add: #helpButton width: 30 ]
			height: 30;
			add: #resultList ]
		origin: 0.46 @ 0 corner: 0.73 @ 1;
		
		newColumn: [ :col | col
			add: #matchMap ]
		origin: 0.73 @ 0 corner: 1 @ 1;
		yourself"
		
	^ SpBoxLayout newHorizontal
		add:
			(SpBoxLayout newVertical
				add: #matchExpression;
				add: #testExpression;
				yourself) ;
		add: (SpBoxLayout newVertical
				add: #executeButton;
				add: #helpButton;
				add: #resultList;
				yourself) ;	
		add: (SpBoxLayout newVertical
				add: #matchMap;
				yourself);
		yourself		
]

{ #category : #menu }
MatchToolPresenter class >> worldMenu: aBuilder [

	<worldMenu>
	(aBuilder item: #MatchTool)
		order: 0.40;
		icon: (self iconNamed: #jigsawIcon);
		parent: #Tools;
		action: [
			self new
				openWithSpec;
				disableLists.
			self flag: 'use #disableLists here to overcome spec issue where #enabled: status is not set on widget construction' ]
]

{ #category : #'event handling' }
MatchToolPresenter >> disableLists [
	resultList disable.
	matchMap disable
]

{ #category : #accessing }
MatchToolPresenter >> executeButton [
	^ executeButton
]

{ #category : #accessing }
MatchToolPresenter >> helpButton [
	^ helpButton
]

{ #category : #'ui display' }
MatchToolPresenter >> initialExtent [
	
	^ 800 @ 400
]

{ #category : #initialization }
MatchToolPresenter >> initializeFocusOrder [
	self focusOrder
		add: matchExpression;
		add: testExpression;
		add: executeButton;
		add: resultList
]

{ #category : #initialization }
MatchToolPresenter >> initializeLists [
	resultList
		disable;
		displayBlock: [ :assoc | assoc key formattedCode ].
	matchMap
		disable;
		addColumn: (StringTableColumn evaluated: [:assoc | assoc key formattedCode]);
		addColumn: (StringTableColumn evaluated: [:assoc | assoc value asString formattedCode]).

]

{ #category : #initialization }
MatchToolPresenter >> initializePresenter [
	matchExpression
		beForPatternCode;
		whenCodeEdited: [ self disableLists ];
		whenMethodStateChangedDo: [ self disableLists ];
		whenMethodActivatedDo: [ self matchMethodActivated ].
	testExpression
		whenCodeEdited: [ self disableLists ];
		whenMethodStateChangedDo: [ self disableLists ];
		whenMethodDeactivatedDo: [ self testMethodDeactivated ].
	executeButton action: [ self performMatching ].
	helpButton action: [ HelpBrowser openOn: MatchToolHelp ].
	resultList
		whenSelectionChangedDo: [ :selection | 
			[ :assoc | self selectedResultsItemChanged: assoc ]
				cull: selection selectedItem ];
		whenModelChangedDo: [ :newItems | self resultsChanged: newItems ]
]

{ #category : #initialization }
MatchToolPresenter >> initializeWidgets [
	self instantiateWidgets.
	matchExpression beForPatternCode.
	executeButton
		icon:
			(self iconNamed: #smallDoIt);
		label: 'Match';
		shortcut: Character cr meta.
	helpButton
		icon: ((self iconNamed: #questionIcon) scaledToSize: 22 @ 22);
		shortcut: $h meta.
	self initializeLists.
	self initializeFocusOrder
]

{ #category : #initialization }
MatchToolPresenter >> instantiateWidgets [
	matchExpression := self instantiate: CodeSnippetPresenter.
	testExpression := self instantiate: CodeSnippetPresenter.
	resultList := self newList.
	executeButton := self newButton.
	helpButton := self newButton.
	matchMap := self newTable
]

{ #category : #testing }
MatchToolPresenter >> isReadyForMatching [

	^ (matchExpression hasUnacceptedEdits or: [ 
		testExpression  hasUnacceptedEdits or: [ 
		matchExpression astNode isNil or: [ 
		testExpression astNode isNil ] ] ]) not
]

{ #category : #accessing }
MatchToolPresenter >> matchExpression [
	^ matchExpression
]

{ #category : #accessing }
MatchToolPresenter >> matchMap [
	^ matchMap
]

{ #category : #initialization }
MatchToolPresenter >> matchMethodActivated [

	testExpression isForMethod: true
]

{ #category : #'event handling' }
MatchToolPresenter >> performMatching [
	| matches |
	matchExpression accept.
	testExpression  accept.
	self isReadyForMatching ifFalse: [ ^ self ].
	
	matches := OrderedCollection new.
	testExpression astNode doSemanticAnalysis.
	testExpression astNode nodesDo: [ :node |
		matchExpression astNode
			match: node
			onSuccess: [ :map |
				matches add: node -> map ]
			onFailure: [  ] ].
		
	resultList enable.
	matchMap   enable.
	resultList items: matches
]

{ #category : #accessing }
MatchToolPresenter >> resultList [
	^ resultList
]

{ #category : #initialization }
MatchToolPresenter >> resultsChanged: newItems [
	matchMap items: #().
	resultList unselectAll.
	^ newItems
		ifEmpty: [ resultList borderColor: Color red ]
		ifNotEmpty: [ resultList borderColor: Color green ]
]

{ #category : #initialization }
MatchToolPresenter >> selectedResultsItemChanged: assoc [
	^ assoc
		ifNil: [ matchMap items: #().
			testExpression clearCodeSelection ]
		ifNotNil: [ matchMap items: assoc value associations.
			testExpression setCodeSelection: assoc key sourceInterval ]
]

{ #category : #accessing }
MatchToolPresenter >> testExpression [
	^ testExpression
]

{ #category : #initialization }
MatchToolPresenter >> testMethodDeactivated [

	matchExpression isForMethod: false
]

{ #category : #'ui display' }
MatchToolPresenter >> title [

	^ 'MatchTool'
]

{ #category : #'ui display' }
MatchToolPresenter >> windowIcon [

	^ self iconNamed: #jigsawIcon
]
