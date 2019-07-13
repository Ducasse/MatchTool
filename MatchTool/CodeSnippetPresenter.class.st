"
A widget with a title label, code area and a  checkbox to switch for method/expression mode.

On accept of the code area the widjet will parse the code into an ast and store it.

The wideget can operate for both smalltalk code and pattern code.
"
Class {
	#name : #CodeSnippetPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'titleLabel',
		'methodCheckbox',
		'codeArea',
		'ast'
	],
	#category : #'MatchTool-CorePresenter'
}

{ #category : #specs }
CodeSnippetPresenter class >> defaultSpec [

	"^ SpecLayout composed 
		newColumn: [ :col | col
				newRow: [ :row | row
					add: #titleLabel;
					add: #methodCheckbox width: 100. ]
				height: 30;
				newRow: [ :row | row add: #codeArea ] 
				];
		yourself"
		
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newVertical
				add: #titleLabel;
				add: #methodCheckbox;
				yourself);
		add: (SpBoxLayout newVertical
					add: #codeArea;
					yourself );
		yourself 
		
]

{ #category : #'code area api' }
CodeSnippetPresenter >> accept [

	codeArea accept
]

{ #category : #'event handling' }
CodeSnippetPresenter >> accept: text notifying: notifier [
	[ ast := self parse: text ]
		on: SyntaxErrorNotification
		do: [ :ex | 
			notifier notify: ex errorMessage at: ex location in: ex errorCode.
			^ false ]
]

{ #category : #accessing }
CodeSnippetPresenter >> astNode [

	^ ast
]

{ #category : #setup }
CodeSnippetPresenter >> beForPatternCode [

	self isForPatternCode: true
]

{ #category : #'code area api' }
CodeSnippetPresenter >> clearCodeSelection [
	codeArea clearSelection 
]

{ #category : #accessing }
CodeSnippetPresenter >> codeArea [
	^ codeArea
]

{ #category : #'code area api' }
CodeSnippetPresenter >> hasUnacceptedEdits [
	^ codeArea hasUnacceptedEdits
]

{ #category : #initialization }
CodeSnippetPresenter >> initializePresenter [
	super initializePresenter.
	titleHolder whenChangedDo: [ :string | titleLabel label: string ].
	methodCheckbox whenChangedDo: [ :bool | codeArea isForMethod: bool ].
	codeArea
		acceptBlock:
			[ :text :notifier | self accept: text notifying: notifier ]
]

{ #category : #initialization }
CodeSnippetPresenter >> initializeWidgets [
	
	titleLabel := self newLabel.
	methodCheckbox := self newCheckBox.
	codeArea := self instantiate: MatchCodePresenter.
	
	titleLabel label: self title.
	methodCheckbox label: 'Method'.
]

{ #category : #setup }
CodeSnippetPresenter >> isForMethod [

	^ methodCheckbox state
]

{ #category : #setup }
CodeSnippetPresenter >> isForMethod: aBool [

	methodCheckbox state: aBool
]

{ #category : #setup }
CodeSnippetPresenter >> isForPatternCode [

	^ codeArea isForMatch
]

{ #category : #setup }
CodeSnippetPresenter >> isForPatternCode: aBoolean [

	codeArea isForMatch: aBoolean
]

{ #category : #accessing }
CodeSnippetPresenter >> methodCheckbox [
	^ methodCheckbox
]

{ #category : #parsing }
CodeSnippetPresenter >> parse: text [

	^ self isForMethod
		ifTrue: [ self parser parseMethod: text ]
		ifFalse: [ self parser parseExpression: text ]

]

{ #category : #parsing }
CodeSnippetPresenter >> parser [

	^ self isForPatternCode
		ifTrue: [ RBPatternParser ]
		ifFalse: [ RBParser ]
]

{ #category : #'code area api' }
CodeSnippetPresenter >> setCodeSelection: anInterval [ 
	
	codeArea setSelection: anInterval
]

{ #category : #accessing }
CodeSnippetPresenter >> titleLabel [
	^ titleLabel
]

{ #category : #'code area api' }
CodeSnippetPresenter >> whenCodeEdited: aBlock [

	codeArea whenEdited: aBlock
]

{ #category : #'checkbox api' }
CodeSnippetPresenter >> whenMethodActivatedDo: aBlock [

	methodCheckbox whenActivatedDo: aBlock
]

{ #category : #'checkbox api' }
CodeSnippetPresenter >> whenMethodDeactivatedDo: aBlock [

	methodCheckbox whenDeactivatedDo: aBlock
]

{ #category : #'checkbox api' }
CodeSnippetPresenter >> whenMethodStateChangedDo: aBlock [

	methodCheckbox whenChangedDo: aBlock
]
